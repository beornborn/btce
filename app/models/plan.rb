class Plan < ActiveRecord::Base
  self.inheritance_column = 'other'
  has_many :orders, dependent: :destroy
  belongs_to :user

  def bd a
    BigDecimal(a.to_s)
  end

  def available_depo
    depo - orders.active.buy.pluck(:spent_usd).compact.sum rescue '-'
  end

  def active_orders
    return [] if orders.active.blank?
    btce_orders = user.btce_api.active_orders.keep_if {|id| orders.active.pluck(:btce_id).include? id.to_i}
    Order.convert_to_obj btce_orders
  end

  def generate_buy_orders
    @comission = bd('0.002')
    btce_orders = []

    @step = (max - min) / (th - 1)

    th.times do |i|
      spent_usd = calculate_spent_usd i
      rate = max - i * @step
      amount = (spent_usd / rate) / (1 + @comission)
      sell_price = calculate_sell_price i

      order = orders.new user: user, pair: pair, type: 'buy', rate: rate.floor(3), amount: amount.floor(3), spent_usd: spent_usd.floor(3), sell_price: sell_price.floor(3), buy_price: rate.floor(3)
      btce_orders << order
    end

    btce_orders
  end

  def calculate_sell_price n
    total_amount = 0
    total_spent_usd = 0
    sell_price = 0

    (n+1).times do |i|
      spent_usd = calculate_spent_usd i
      rate = max - i * @step
      amount = (spent_usd / rate) / (1 + @comission)
      total_amount += amount
      total_spent_usd += spent_usd
      sell_price = (total_spent_usd / total_amount) * (1 + @comission) * pr
    end
    sell_price
  end

  def calculate_spent_usd num
    sum = ([nil] * th).each_with_index.map {|x,i| martin ** i }.sum
    spent_usd = (martin ** num) * depo / sum
    bd(spent_usd.to_s).floor(2)
  end

  def create_buy
    generate_buy_orders.select {|x| x.rate < BtceApi.current_rate(pair)}.each {|x| x.save!}
  end

  def create_sell
    generate_buy_orders.select {|x| x.rate > BtceApi.current_rate(pair)}.map(&:build_derivative).each {|x| x.save!}
  end

  def cancel_all
    orders.each {|order| order.cancel }
  end
end

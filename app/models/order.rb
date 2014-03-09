class Order < ActiveRecord::Base
  include ActiveModel::Transitions

  self.inheritance_column = 'other'
  belongs_to :plan
  belongs_to :user

  scope :active, ->{where('state = ?', 'active')}
  scope :active_or_billet, ->{where(state: %w(active billet))}
  scope :not_active, ->{where('state <> ?', 'active')}
  scope :buy, ->{where(type: 'buy')}

  state_machine do
    state :billet
    state :active
    state :cancelled
    state :fired

    event :publish do
      transitions from: :billet, to: :active, on_transition: :publish
    end

    event :cancel do
      transitions from: :active, to: :cancelled, on_transition: :cancel
    end

    event :fire do
      transitions from: :active, to: :fired
    end
  end

  def published?
    persisted? && user.order_by_btce_id(btce_id).present?
  end

  def store!
    self.attributes = {
      state: 'active',
      "#{type}_price".to_sym => rate
    }
    self.save!
  end

  def stored?
    Order.find_by(btce_id: self.btce_id).present?
  end

  def timestamp_created=val
    if val.is_a? Fixnum
      write_attribute(:timestamp_created, Time.at(val))
    else
      super
    end
  end

  def self.convert_to_obj api_orders
    api_orders.map do |btce_id, api_order|
      order = Order.new
      order.attributes = api_order.merge({btce_id: btce_id})
      order
    end
  end

  def cancel
    user.btce_api.cancel_order btce_id
  end

  def self.cancel_all orders
    orders.each {|order| order.cancel!}
  end

  def publish
    response = user.btce_api.trade pair, type, rate.to_f, amount.to_f
    if response
      self.btce_id = response['order_id']
      self.attributes = current_user.btce_api.active_orders[self.btce_id.to_s]
      self.save!
    end
  end

  def create_derivative
    d = self.dup
    d.attributes = {
      btce_id: nil,
      timestamp_created: nil,
      status: nil,
      spent_usd: nil,
      type: contr_type,
      rate: send("#{contr_type}_price"),
      state: 'billet'
    }
    d.save!
    d
  end

  def contr_type
    return 'sell' if type == 'buy'
    return 'buy' if type == 'sell'
  end
end

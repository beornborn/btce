class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, uniqueness: true

  has_many :plans
  has_many :orders

  def api_allowed?; api_allowed; end

  def active_orders
    btce_orders = btce_api.active_orders.each {|btce_id,val| val['user_id'] = self.id}
    Order.convert_to_obj btce_orders
  end

  def order_by_btce_id btce_id
    active_orders.detect {|x| x.btce_id == btce_id.to_i}
  end

  def btce_api
    BtceApi.new self
  end

  def funds cur
    btce_api.get_info['funds'][cur]
  end

  def cancel_all
    btce_api.active_orders.keys.each do |id|
      order = Order.find_by(btce_id: id.to_i)
      if order
        order.cancel
      else
        btce_api.cancel_order id
      end
    end
  end
end

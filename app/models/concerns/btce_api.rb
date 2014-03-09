require 'rest_client'

class BtceApi
  class RequestError < StandardError; end
  class ApiNotAllowedError < StandardError; end

  def initialize user
    @user = user
  end

  def self.current_rate pair
    url = "https://btc-e.com/api/3/trades/#{pair}?limit=1"
    JSON.parse(RestClient.get url)[pair][0]['price']
  end

  def sign(params)
    hmac = OpenSSL::HMAC.new(@user.btce_secret, OpenSSL::Digest::SHA512.new)
    params = params.collect {|k,v| "#{k}=#{v}"}.join('&')
    signed = hmac.update params
  end

  def send_request method, params = {}
    url = 'https://btc-e.com/tapi'
    nonce = SystemData.find_by(name: 'nonce')
    request_params = params.merge({method: method, nonce: nonce.val})

    response = JSON.parse RestClient.post(url, request_params, :content_type => :json, :accept => :json, :'Key' => @user.btce_key, :'Sign'=>sign(request_params))
    nonce.val += 1
    nonce.save!
    response
  end

  def get_info
    return {} unless @user.api_allowed?
    handle_response send_request('getInfo'), __method__
  end

  def active_orders
    return {} unless @user.api_allowed?
    handle_response send_request('ActiveOrders'), __method__
  end

  def trade pair, type, rate, amount
    return {} unless @user.api_allowed?
    handle_response send_request('Trade', {pair: pair, type: type, rate: rate, amount: amount}), __method__
  end

  def cancel_order order_id
    return {} unless @user.api_allowed?
    handle_response send_request('CancelOrder', {order_id: order_id}), __method__
  end

  def handle_response response, method
    return [] if response['success'] != 1 && method == :active_orders && (response['error'] == 'no orders' || !@user.api_allowed?)
    raise RequestError, response['error'] if response['success'] != 1
    response['return']
  end
end

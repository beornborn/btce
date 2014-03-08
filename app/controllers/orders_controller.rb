class OrdersController < ApplicationController
  def index
    @info = User.first.btce_api.get_info
    @database_orders = User.first.orders.active_or_billet.order('timestamp_created desc')
    @btce_orders = User.first.active_orders.sort {|x,y| y.timestamp_created<=>x.timestamp_created}
  end

  def new
    @order = Order.new plan_id: params[:plan_id], pair: params[:pair]
  end

  def update
    order = Order.find params[:id]
    order.update_attributes params[:order]
    redirect_to :back
  end

  def create
    order = Order.new params[:order]
    order.user = User.first
    order.save!
    redirect_to plan_path(order.plan) and return if order.plan.present?
    redirect_to :back
  end

  def edit
    @order = Order.find params[:id]
  end

  def store
    order = User.first.orders.find_by(btce_id: params[:btce_id])
    User.first.order_by_btce_id(params[:btce_id]).store! if order.blank?
    redirect_to :back
  end

  def cancel_all
    Order.cancel_all User.first.orders.active
    redirect_to root_path
  end

  def new_btce
    @order = Order.new
  end

  def create_btce
    User.first.btce_api.trade params[:order][:pair], params[:order][:type], params[:order][:rate].to_f, params[:order][:amount].to_f
    redirect_to root_path
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to :back
  end

  def cancel
    order = Order.where('id = ? OR btce_id = ?', params[:id], params[:id]).first
    if order
      order.cancel!
    else
      User.first.btce_api.cancel_order params[:id].to_i
    end
    redirect_to :back
  end

  def publish
    order = Order.find params[:id]
    order.publish!
    redirect_to :back
  end

  def create_derivative
    order = Order.find params[:id]
    order.create_derivative
    redirect_to :back
  end
end

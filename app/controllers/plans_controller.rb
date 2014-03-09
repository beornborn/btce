class PlansController < ApplicationController
  before_action :get_info, only: [:show]

  def index
    @plans = current_user.plans
  end

  def new
    @plan = Plan.new
  end

  def edit
    @plan = Plan.find params[:id]
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update_attributes params[:plan]
    redirect_to plan_path(@plan)
  end

  def create
    @plan = current_user.plans.create! params[:plan]
    redirect_to plan_path(@plan)
  end

  def generate_billets
    Plan.find(params[:id]).send("create_#{params[:type]}")
    redirect_to :back
  end

  def show
    @plan = Plan.find params[:id]
    @database_orders = @plan.orders.order('state asc, timestamp_created asc')
    @btce_orders = @plan.active_orders
  end

  def cancel_all
    plan = Plan.find params[:id]
    Order.cancel_all plan.orders.active
    redirect_to plan_path(plan)
  end

  def delete_not_active
    plan = Plan.find params[:id]
    Order.where(id: plan.orders.not_active.pluck(:id)).delete_all
    redirect_to :back
  end

  def destroy
    plan = Plan.find params[:id]
    plan.orders.each {|order| order.cancel }
    plan.destroy!
    redirect_to plans_path
  end
end

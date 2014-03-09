class PlansController < ApplicationController
  before_action :get_info, only: [:show]
  before_action :set_plan, only: [:edit, :update, :show, :destroy, :generate_billets, :cancel_all, :delete_not_active]

  def index
    @plans = current_user.plans
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.create! params[:plan]
    redirect_to plan_path(@plan)
  end

  def edit
  end

  def update
    @plan.update_attributes params[:plan]
    redirect_to plan_path(@plan)
  end

  def show
    @database_orders = @plan.orders.order('state asc, timestamp_created asc')
    @btce_orders = @plan.active_orders
  end

  def destroy
    @plan.orders.each {|order| order.cancel }
    @plan.destroy!
    redirect_to plans_path
  end

  def generate_billets
    @plan.send("create_#{params[:type]}")
    redirect_to :back
  end

  def cancel_all
    Order.cancel_all @plan.orders.active
    redirect_to plan_path(@plan)
  end

  def delete_not_active
    Order.where(id: @plan.orders.not_active.pluck(:id)).delete_all
    redirect_to :back
  end

  private
    def set_plan
      @plan = Plan.find params[:id]
    end
end

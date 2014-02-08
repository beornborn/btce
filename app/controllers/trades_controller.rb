class TradesController < ApplicationController
  def continue_chart
    trade = Trade.find(params[:id])

    database_data = trade.options[:model_name].constantize.select('time, open, high, low, close, amount, tramount').where('time >= ? and time <= ?', trade.begin - 7.day, trade.end).order('time asc').to_a

    render json: to_chart_data(database_data)
  end

  def index
    @trades = Trade.all
  end

  def new
    @trade = Trade.new
  end

  def continue
    @trade = Trade.find params[:id]
  end

  def create
    @trade = Trade.new(params[:trade])
    @trade.options = {description: params[:description], model_name: params[:interval]}
    @trade.end = @trade.begin
    @trade.save!
    redirect_to trades_path
  end

  def show
    @trade = Trade.find params[:id]
  end
end

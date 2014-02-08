class TradesController < ApplicationController
  def continue_chart
    trade = Trade.find(params[:id])
    intervals = []
    volumes = []
    tramounts = []
    trade.options[:model_name].constantize.select('time, open, high, low, close, amount, tramount').where('time >= ? and time <= ?', trade.begin - 7.day, trade.end).order('time asc').each do |min|
      intervals << [min.time.to_i*1000, min.open.to_f, min.high.to_f, min.low.to_f, min.close.to_f]
      volumes << [min.time.to_i*1000, min.amount.to_f, min.tramount.to_f]
      tramounts << [min.time.to_i*1000, min.tramount.to_f]
    end

    render json: {intervals: intervals, volumes: volumes, tramounts: tramounts}
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

  def chart
    trade = Trade.find(params[:id])

    begin_by_param = Date.parse(params[:begin])
    end_by_param = Date.parse(params[:end])
    begin_by_tr = trade.trade_results.order('time asc').first.time
    end_by_tr = trade.trade_results.order('time asc').last.time
    begin_t = [begin_by_param, begin_by_tr].max
    end_t = [end_by_param, end_by_tr].min

    minutes = Minute.select('time, open, high, low, close').where('time >= ? and time <= ?', begin_t, end_t).order('time asc').map do |min|
      [min.time.to_i*1000, min.open.to_f, min.high.to_f, min.low.to_f, min.close.to_f]
    end

    trade_results = trade.trade_results.select('time, estimate_usd').where('time >= ? and time <= ?', begin_t, end_t).order('time asc').map do |tr|
      [tr.time.to_i*1000, tr.estimate_usd.to_i - 1000]
    end

    flags = trade.trade_results.select('time, action').where.not(action: nil).order('time asc').map do |tr|
      {x: tr.time.to_i*1000, title: tr.action}
    end

    render json: {minutes: minutes, trade: trade_results, flags: flags, rate: trade.profit_rate}
  end
end

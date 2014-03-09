class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :destroy, :continue_chart, :trade_results, :profit_rate_by_range, :do_trade, :get, :last_ichimoku_point, :last_chart_point, :set_trade]

  def index
    @trades = if %w(low_volume up modern).include? params[:attr]
      Trade.all.sort {|x, y|y.options[params[:attr].to_sym].to_f <=> x.options[params[:attr].to_sym].to_f }
    else
      Trade.order('profit_rate desc').all
    end
  end

  def new
    @trade = Trade.new
  end

  def create
    @trade = Trade.new(params[:trade])
    @trade.options = {description: params[:description], model_name: params[:interval]}
    @trade.end = @trade.begin
    @trade.usd = @trade.estimate_usd = @trade.initial_usd
    @trade.btc = 0
    @trade.save!
    redirect_to trades_path
  end

  def show
  end

  def destroy
    @trade.destroy
    redirect_to trades_path
  end

  def continue_chart
    database_data = @trade.options[:model_name].constantize.select('time, open, high, low, close, amount, tramount').where('time >= ? and time <= ?', @trade.end - 7.day, @trade.end).order('time asc').to_a

    render json: to_chart_data(database_data)
  end

  def trade_results
    tr = @trade.trade_results.select('time, action').order('time asc').map do |r|
      {x: r.time.to_i*1000, title: r.action}
    end

    render json: tr
  end

  def profit_rate_by_range
    profit_rate = @trade.profit_rate_by_range Time.at(params[:begin].to_i), Time.at(params[:end].to_i)

    render json: profit_rate
  end

  def continue
    @trade_id = params[:id]
  end

  def analyze
    @trade_id = params[:id]
  end

  def do_trade
    @trade.act = params[:act]
    @trade.current_situation = @trade.options[:model_name].constantize.find_by(time: @trade.end)

    @trade.manual_trade

    render json: {success: true} if @trade.save!
  end

  def get
    last_tr = @trade.trade_results.order('time asc').last
    render json: @trade.as_json.merge(strategy: @trade.strategy)
  end

  def last_ichimoku_point
    indicator = Indicator.find_by(name: 'ichimoku')
    chinkou_time = [@trade.end, Time.now].min - indicator.options[:medium]
    intervals = {tenkan_sen: [], kijun_sen: [], chinkou_span: [], senkou_span_a: [], senkou_span_b: []}
    indicator.ichimokus.where('time = ?', @trade.end).map do |val|
      intervals[:tenkan_sen] << [val.time.to_i*1000, val.tenkan_sen.to_f]
      intervals[:kijun_sen] << [val.time.to_i*1000, val.kijun_sen.to_f]
      intervals[:senkou_span_a] << [val.time.to_i*1000, val.senkou_span_a.to_f]
      intervals[:senkou_span_b] << [val.time.to_i*1000, val.senkou_span_b.to_f]
    end

    indicator.ichimokus.where('time = ?', chinkou_time).map do |val|
      intervals[:chinkou_span] << [val.time.to_i*1000, val.chinkou_span.to_f]
    end
    render json: intervals
  end

  def last_chart_point
    point = @trade.model.find_by(time: @trade.end)
    render json: to_chart_data([point])
  end

  private
    def set_trade
      @trade = Trade.find params[:id]
    end
end

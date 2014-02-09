class TradesController < ApplicationController
  def continue_chart
    trade = Trade.find(params[:id])

    database_data = trade.options[:model_name].constantize.select('time, open, high, low, close, amount, tramount').where('time >= ? and time <= ?', trade.end - 7.day, trade.end).order('time asc').to_a

    render json: to_chart_data(database_data)
  end

  def index
    @trades = Trade.all
  end

  def new
    @trade = Trade.new
  end

  def continue
    @trade_id = params[:id]
  end

  def do_trade
    trade = Trade.find params[:id]

    trade.buy_for trade.usd if params[:act] == 'buy'
    trade.sell trade.btc if params[:act] == 'sell'

    trade.store_result params[:act] unless params[:act] == 'wait'
    trade.end += MOD_INT[trade.options[:model_name]]
    render json: {success: true} if trade.save!
  end

  def get
    trade = Trade.find(params[:id])
    last_tr = trade.trade_results.order('time asc').last
    usd = last_tr.try(:usd) || trade.initial_usd.to_f
    btc = last_tr.try(:btc) || 0
    render json: trade.as_json.merge(usd: usd, btc: btc, begin: trade.begin, end: trade.end)
  end

  def last_ichimoku_point
    trade = Trade.find(params[:id])
    indicator = Indicator.find_by(name: 'ichimoku')
    chinkou_time = [trade.end, Time.now].min - indicator.options[:medium]
    intervals = {tenkan_sen: [], kijun_sen: [], chinkou_span: [], senkou_span_a: [], senkou_span_b: []}
    indicator.ichimokus.where('time = ?', trade.end).map do |val|
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
    trade = Trade.find(params[:id])
    point = trade.model.find_by(time: trade.end)
    render json: to_chart_data([point])
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
    @trade = Trade.find params[:id]
  end
end

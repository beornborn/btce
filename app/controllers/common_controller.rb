class CommonController < ApplicationController
  def index
    @begin = Hour.order('time asc').first.time
    @end = Hour.order('time asc').last.time + 1.day
  end

  def chart
    begin_t = Date.parse(params[:begin])
    end_t = Date.parse(params[:end])
    model = (params[:model] || 'hour').camelize.constantize

    database_data = model.select('time, open, high, low, close, amount, tramount').where('time >= ? and time <= ?', begin_t, end_t).order('time asc').to_a

    render json: to_chart_data(database_data)
  end

  def ichimoku
    begin_t = Date.parse(params[:begin])
    end_t = Date.parse(params[:end])
    chinkou_limit = [end_t, Time.now].min
    indicator = Indicator.find_by(name: 'ichimoku')

    intervals = {tenkan_sen: [], kijun_sen: [], chinkou_span: [], senkou_span_a: [], senkou_span_b: []}
    indicator.ichimokus.select('time, tenkan_sen, kijun_sen, chinkou_span, senkou_span_a, senkou_span_b').where('time >= ? and time <= ?', begin_t, end_t).order('time asc').map do |val|
      intervals[:tenkan_sen] << [val.time.to_i*1000, val.tenkan_sen.to_f]
      intervals[:kijun_sen] << [val.time.to_i*1000, val.kijun_sen.to_f]
      intervals[:chinkou_span] << [val.time.to_i*1000, val.chinkou_span.to_f] unless val.time > chinkou_limit-indicator.options[:medium]
      intervals[:senkou_span_a] << [val.time.to_i*1000, val.senkou_span_a.to_f]
      intervals[:senkou_span_b] << [val.time.to_i*1000, val.senkou_span_b.to_f]
    end

    render json: intervals
  end

  def point_details
    time = Time.at(params[:time].to_i)
    ichi = Ichimoku.find_by(time: time)
    if ichi
      details = {
        time: ichi.time,
        tenkan_sen: ichi.tenkan_sen,
        kijun_sen: ichi.kijun_sen,
        chinkou_span: ichi.chinkou_span,
        senkou_span_a: ichi.senkou_span_a,
        senkou_span_b: ichi.senkou_span_b
      }
    end
    render json: (details || {point: 'not found'})
  end

  def signals
    signals = Indicator.find(params[:indicator_id]).options[:signals]
    render json: signals
  end
end

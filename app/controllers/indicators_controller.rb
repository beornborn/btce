class IndicatorsController < ApplicationController
  def data
    begin_t = Time.parse(params[:begin])
    end_t = Time.parse(params[:end])

    chinkou_limit = [end_t, Time.now].min
    indicator = Indicator.find(params[:id])

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

  def signals
    signals = Indicator.find(params[:id]).options[:signals]
    render json: signals
  end
end

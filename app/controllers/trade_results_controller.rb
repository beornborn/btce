class TradeResultsController < ApplicationController
  def find
    time = Time.at(params[:time].to_i)
    tr = TradeResult.select('usd, btc, estimate_usd, estimate_btc, price').where(trade_id: params[:trade_id], time: time).first.as_json
    tr.delete 'id'
    render json: tr
  end


  def point_details

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
end

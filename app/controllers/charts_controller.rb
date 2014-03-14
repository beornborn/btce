class ChartsController < ApplicationController
  def index
    @begin = Hour.order('time asc').first.time
    @end = Hour.order('time asc').last.time + 1.day
  end

  def data
    begin_t = Time.parse(params[:begin])
    end_t = Time.parse(params[:end])
    model = (params[:model] || 'hour').camelize.constantize

    database_data = model.select('time, open, high, low, close, amount, tramount').where('time >= ? and time <= ?', begin_t, end_t).order('time asc').to_a

    render json: to_chart_data(database_data)
  end
end

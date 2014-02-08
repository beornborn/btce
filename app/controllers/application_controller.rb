class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "beornborn", password: "beo123"
  before_action :permit_all

  def permit_all
    params.permit!
  end

private

  def to_chart_data(data)
    intervals, volumes, tramounts = [], [], []
    data.each do |min|
      intervals << [min.time.to_i*1000, min.open.to_f, min.high.to_f, min.low.to_f, min.close.to_f]
      volumes << [min.time.to_i*1000, min.amount.to_f, min.tramount.to_f]
      tramounts << [min.time.to_i*1000, min.tramount.to_f]
    end

    {intervals: intervals, volumes: volumes, tramounts: tramounts}
  end
end

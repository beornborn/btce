class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "beornborn", password: "ololoololoololo43211"
  before_action :permit_all, :require_login

  def permit_all
    params.permit!
  end

  def get_info
    ap current_user.btce_api.get_info
    @info = current_user.btce_api.get_info
  end

private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def to_chart_data(data)
    intervals, volumes, tramounts = [], [], []
    data.each do |min|
      intervals << intervals_to_chart_format(min)
      volumes << volumes_to_chart_format(min)
      tramounts << tramounts_to_chart_format(min)
    end

    {intervals: intervals, volumes: volumes, tramounts: tramounts}
  end

  def intervals_to_chart_format(min)
    [min.time.to_i*1000, min.open.to_f, min.high.to_f, min.low.to_f, min.close.to_f]
  end

  def volumes_to_chart_format(min)
    [min.time.to_i*1000, min.amount.to_f, min.tramount.to_f]
  end

  def tramounts_to_chart_format(min)
    [min.time.to_i*1000, min.tramount.to_f]
  end
end

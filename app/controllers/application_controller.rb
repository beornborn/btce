class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "beornborn", password: "beo123"
  before_action :permit_all

  def permit_all
    params.permit!
  end
end
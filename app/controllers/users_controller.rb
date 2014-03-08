class UsersController < ApplicationController
  def toggle_api
    user = User.first
    user.update_attribute(:api_allowed, !user.api_allowed)
    redirect_to :back
  end
end

class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
    render layout: 'auth'
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to root_path
    else
      render action: "new"
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end

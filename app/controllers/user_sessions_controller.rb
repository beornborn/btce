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
      render action: "new", layout: 'auth'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  def guest_enter
    user = User.find_or_create_by(guest: true) do |u|
      u.email = 'guest@guest.com'
    end

    @user = auto_login(user)
    redirect_back_or_to root_path, success: 'Guest session. You can see but you can\'t change anything'
  end
end

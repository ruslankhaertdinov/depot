class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    @cart = current_cart
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_url = if session[:prev_url].present?
        session[:prev_url]
      else
        user.try(:admin) ? admin_url : store_url
      end
      session[:prev_url] = nil

      redirect_to redirect_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end

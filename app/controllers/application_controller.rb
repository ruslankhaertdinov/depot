class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :current_user_admin?

  before_filter :authorize
  before_filter :authorize_admin
  before_filter :set_i18n_locale_from_params


  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def current_user_admin?
    current_user.try(:admin)
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def authorize_admin
    unless User.find_by_id(session[:user_id]).try(:admin)
      redirect_to login_url
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
            "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end
end

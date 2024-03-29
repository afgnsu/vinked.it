class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  WillPaginate.per_page = 10

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: I18n.t('.general.not_authorized')
  end

  def set_locale
    I18n.locale = session[:locale]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me, :uid, :provider) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :screen_name, :location, :email, :locale, :password, :password_confirmation, :role, :subscription) }
  end
end
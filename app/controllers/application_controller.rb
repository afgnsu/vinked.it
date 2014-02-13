class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  WillPaginate.per_page = 10

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: I18n.t('.general.not_authorized')
  end

  # Let Devise redirect to the last stored URL or the root URL when it has no specific page to
  # redirect back to. This overrides normal Devise behaviour that would have
  # it redirect to the users overview.
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.locale.to_sym != I18n.locale
      I18n.locale = resource.locale.to_sym
      session[:locale] = I18n.locale
    end
    session[:user_return_to] || root_url
    super
  end

  def set_locale
    I18n.locale = session[:locale]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :screen_name, :location, :email, :locale, :password, :password_confirmation) }
  end
end
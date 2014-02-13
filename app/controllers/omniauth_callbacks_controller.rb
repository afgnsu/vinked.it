class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = I18n.t('.devise.omniauth_callbacks.success')
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url, notice: I18n.t('.devise.omniauth_callbacks.failure')
    end
  end
  alias_method :twitter, :all
end

class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_for_authentication(email: user_params[:email])
    if user && user.valid_password?(user_params[:password])
      user.generate_authentication_token
      expose({
        user_id: user.id,
        token: user.authentication_token
      })
    else
      error! :unauthenticated
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
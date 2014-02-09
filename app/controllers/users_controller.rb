class UsersController < ApplicationController

  def index
    authorize! :index, User
    @users = User.all
  end

  def show
    authorize! :show, User
    @user = User.find(params[:id])
    @clubs = Club.includes(:vinks).where("vinks.user_id = ?", @user.id).uniq.order("vinks.vink_date DESC")
    @commentable = @user
    @comments = @commentable.comments
    @comment = Comment.new
    @vink = Vink.new
    @form_clubs = Club.order(:name)
    @form_leagues = League.order("level, name")
    @calculator = VinkCalculator.new
  end

  def update
    authorize! :update, User

    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, notice: I18n.t('.users.message_update')
    else
      render action: "edit"
    end
  end

  def destroy
    authorize! :destroy, User

    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, notice: I18n.t('.users.message_delete')
    else
      redirect_to users_path, notice: I18n.t('.users.message_self')
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :screen_name, :email, :password, :location, :locale)
  end

end
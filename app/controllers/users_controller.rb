class UsersController < ApplicationController

  def index
    authorize! :index, User
    @users = User.all
  end

  def show
    authorize! :show, User
    @user = User.find(params[:id])
    @vinks = @user.vinks.order("vink_date DESC")
    @commentable = @user
    @comments = @commentable.comments
    @comment = Comment.new
    @calculator = VinkCalculator.new

    #@countries = GraphBuilder.new.show_countries(@user)
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
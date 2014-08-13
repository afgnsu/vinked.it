class UsersController < ApplicationController

  def index
    authorize! :index, User
    @users = User.all
  end

  def show
    authorize! :show, User

    @user = User.find(params[:id])

    if params[:keyword].present?
      @vinks = Search.for(params[:keyword], params[:user_id])
    elsif params[:next_vink_nr].present?
      @vinks = @user.vinks.next_vinks(params[:next_vink_nr])
    elsif params[:prev_vink_nr].present?
      @vinks = @user.vinks.prev_vinks(params[:prev_vink_nr])
    else
      @vinks = @user.vinks.order("vink_nr DESC").limit(10)
    end
  end

  def profile
    authorize! :profile, User
    @user = User.find(params[:user_id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    authorize! :update, User

    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_profile_path(@user), notice: I18n.t('.users.message_update')
    else
      render action: "edit"
    end
  end

  def destroy
    authorize! :destroy, User

    user = User.find(params[:id])
    user.destroy

    redirect_to root_path, notice: I18n.t('.users.message_delete')
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :screen_name, :email, :password, :location, :locale, :subscription)
  end

end

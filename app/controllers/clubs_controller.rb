class ClubsController < ApplicationController
  def index
    authorize! :index, Club

    if params[:view] == "own"
      @clubs = current_user.clubs.includes(:vinks).order("vinks.vink_date DESC")
    else
      @clubs = Club.includes(:vinks).order("name")
    end
  end

  def new
    @club = Club.new
    @leagues = League.includes(:country).order(:name)
  end

  def create
    authorize! :create, Club

    @club = Club.new(club_params)

    if @club.save
      flash[:success] = I18n.t(".clubs.messages.created")
      redirect_to clubs_path
    else
      @leagues = League.includes(:country).order(:name)
      render action: "new"
    end
  end

  def edit
    @club = Club.find(params[:id])
    @leagues = League.includes(:country).order(:name)
   end

  def update
    authorize! :update, Club

    @club = Club.find(params[:id])

    if @club.update_attributes(club_params)
      flash[:success] = I18n.t(".clubs.messages.updated")
      redirect_to clubs_path
    else
      @leagues = League.includes(:country).order(:name)
      render action: "edit"
    end
  end

  def destroy
    authorize! :destroy, Club

    @club = Club.find(params[:id])
    @club.destroy

    flash[:success] = I18n.t(".clubs.messages.removed")
    redirect_to clubs_path
  end

  private

  def club_params
    params.require(:club).permit(:name)
  end

end

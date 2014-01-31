class ClubsController < ApplicationController
  def index
    authorize! :index, Club

    @clubs = Club.order("name")
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

    flash[:success] = I18n.t(".clubs.messages.deleted")
  end

  private

  def club_params
    params.require(:club).permit(:name)
  end

end

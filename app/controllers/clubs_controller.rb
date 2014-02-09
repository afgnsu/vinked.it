class ClubsController < ApplicationController
  def index
    authorize! :index, Club

    if params[:view] == "own"
      @clubs = Club.includes(:vinks).where("vinks.user_id = ?", current_user.id).uniq.order("vinks.vink_date DESC")
    elsif params[:view] == "all"
      @clubs = Club.includes(:vinks).order("name")
    elsif params[:view] == "latest"
      @clubs = Club.includes(:vinks).order("vinks.vink_date DESC").limit(25)
    end
    form_data
  end

  def show
    @club = Club.includes(:vinks).find(params[:id])

    if params[:view] == "own_vinkedits"
      @vinks = current_user.vinks.where(club_id: @club.id).order("vinks.vink_date DESC")
    elsif params[:view] == "vinkedits"
      @vinks = Vink.where(club_id: @club.id).order("vinks.vink_date DESC")
    elsif params[:view] == "users"
      @users = User.includes(:vinks).where("vinks.club_id = ?", @club.id).order(:last_name)
    else
      params[:view] = "comments"
      puts "HUH #{params[:view]}"
      @commentable = @club
      @comments = @commentable.comments
      @comment = Comment.new
    end

    form_data
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
      redirect_to clubs_path(view: "all")
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
      redirect_to clubs_path(view: "all")
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
    redirect_to clubs_path(view: "all")
  end

  private

  def club_params
    params.require(:club).permit(:name, :country_id, :latitude, :longitude)
  end

  def form_data
    @vink = Vink.new
    @form_clubs = Club.order(:name)
    @form_leagues = League.order("level, name")
    @calculator = VinkCalculator.new
  end
end

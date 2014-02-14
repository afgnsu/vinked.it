class ClubsController < ApplicationController
  def index
    authorize! :index, Club

    collection = Collections::ClubCollection.new(current_ability, params, current_user)
    @clubs = collection.items

    if params[:view].blank?
      @maintenance = true
    end

    form_data

    respond_to do |format|
      format.js
      format.html
    end

  end

  def show
    @club = Club.includes(:vinks).find(params[:id])

    if params[:view] == "own_vinkedits"
      @vinks = current_user.vinks.where(club_id: @club.id).order("vinks.vink_date DESC")
    elsif params[:view] == "vinkedits"
      @vinks = Vink.where(club_id: @club.id).order("vinks.vink_date DESC")
    elsif params[:view] == "users"
      @users = User.includes(:vinks).where("vinks.club_id = ?", @club.id).uniq.order(:screen_name)
    else
      params[:view] = "comments"
      @commentable = @club
      @comments = @commentable.comments.order("created_at ASC")
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
    params.require(:club).permit(:name, :country_id, :latitude, :longitude)
  end

  def form_data
    @vink = Vink.new
    @form_clubs = Club.order(:name)
    @form_leagues = League.order("level, name")
    @countries = Country.order(:country)
    @calculator = VinkCalculator.new
    @letter_array = Club.set_alphabet_letters
  end
end

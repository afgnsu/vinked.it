class LeaguesController < ApplicationController
  def index
    authorize! :index, League

    if params[:country].blank?
      country = Country.where(country: "England").first
      @leagues = League.includes(:country).where(country_id: country).order("level, name")
    else
      @leagues = League.includes(:country).where(country_id: params[:country]).order("level, name")
    end
    @countries = Country.order(:country)
  end

  def new
    authorize! :create, League

    @league = League.new
    @countries = Country.order("country")
  end

  def create
    authorize! :create, League

    @league = League.new(league_params)

    if @league.save
      flash[:success] = I18n.t(".leagues.messages.created")
      redirect_to leagues_path
    else
      @countries = Country.order("country")
      render action: "new"
    end
  end

  def edit
    authorize! :update, League

    @league = League.find(params[:id])
    @countries = Country.order("country")
   end

  def update
    authorize! :update, League

    @league = League.find(params[:id])

    if @league.update_attributes(league_params)
      flash[:success] = I18n.t(".leagues.messages.updated")
      redirect_to leagues_path
    else
      @countries = Country.order("country")
      render action: "edit"
    end
  end

  def destroy
    authorize! :destroy, League

    @league = League.find(params[:id])
    @league.destroy

    flash[:success] = I18n.t(".leagues.messages.deleted")
    redirect_to leagues_path
  end

  private

  def league_params
    params.require(:league).permit(:name, :name_short, :level, :country_id)
  end

end

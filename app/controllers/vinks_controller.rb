class VinksController < ApplicationController

  def create
    authorize! :create, Vink

    @vink = Vink.new(vink_params)
    @vink.save

    respond_to do |format|
      format.js
    end
  end

  def edit
    @vink = Vink.find(params[:id])
    @form_clubs = Club.order(:name)
    @form_leagues = League.order("level, name")
    @calculator = VinkCalculator.new

    respond_to do |format|
      format.js
    end
  end

  def update
    authorize! :update, Vink

    @vink = Vink.find(params[:id])
    @vink.update_attributes(vink_params)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize! :destroy, Vink

    @vink = Vink.destroy(params[:id])

    respond_to do |format|
      format.js
    end
  end


  private

  def vink_params
    params.require(:vink).permit(:vink_date, :vink_nr, :ground, :street, :city, :result,
      :season, :kickoff, :gate, :ticket, :rating, :club_id, :away_club_id, :user_id, :countfor92, :league_id)
  end

end

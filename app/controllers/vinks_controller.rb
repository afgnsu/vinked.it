class VinksController < ApplicationController

  def create
    authorize! :create, Vink

    @vink = Vink.new(vink_params)
    @vink.vink_nr = VinkCalculator.new.assign_vink_nr(current_user)
    @vink.save!

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
    params.require(:vink).permit(:vink_nr, :vink_date, :ground, :street, :city, :latitude, :longitude, :result,
      :season, :kickoff, :gate, :ticket, :rating, :club_id, :away_club_id, :user_id)
  end

end

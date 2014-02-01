class VinksController < ApplicationController
  def index
    authorize! :index, Vink

    if params[:view] == "own"
      @vinks = current_user.vinks.includes(:club).order("vink_date DESC")
    else
      @vinks = Vink.includes(:club).order("vink_date DESC")
    end
  end

  def new
    @vink = Vink.new
  end
=begin
  def create
    authorize! :create, Vink

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
=end
  def destroy
    authorize! :destroy, Vink

    @ink = Vink.destroy(params[:id])

    respond_to do |format|
      format.js
    end
  end


  private

  def vink_params
    params.require(:vink).permit(:vink_nr, :vink_date, :ground, :street, :city, latitude, :longitude, :result,
      :season, :kickoff, :gate, :ticket, :rating, :club_id, :away_club_id, :user_id)
  end

end
=begin

  def create
    authorize! :create, Activity

    @activity = Activity.new(activity_params)
    respond_to do |format|
      if @activity.save
        if @activity.timesheet.status == "open"
          @activity.timesheet.update_attributes(status: "in_progress")
        end
         format.html { redirect_to user_timesheet_path(current_user, @activity.timesheet), notice: I18n.t('.timesheet.message_create') }
         format.js
      else
         format.html { redirect_to user_timesheet_path(current_user, @activity.timesheet), alert: I18n.t('.timesheet.message_failure')  }
         format.js
      end
    end
  end
=end

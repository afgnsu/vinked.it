class Api::V1::VinksController < Api::V1::BaseController
  def index
    expose @current_user.vinks.order("vink_nr DESC")
  end
end
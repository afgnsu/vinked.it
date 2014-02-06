class SiteController < ApplicationController
  def index
    if current_user
      redirect_to clubs_path(view: "own")
    end
  end
end

class SiteController < ApplicationController
  def index
    if current_user
      render clubs_path(view: "own")
    end
  end
end

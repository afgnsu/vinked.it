class GraphBuilder

  def initialize
  end

  def show_countries(user)
    @countries = Array.new
    @countries << ["Country", "Vinks"]
    countries = Country.all
    countries.each do |country|
      @countries << ["#{country.country}", user.vinks.joins(:club).where("clubs.country_id = ?", country.id).count]
    end
    @countries
  end

  def show_leagues(user)
    @leagues = Array.new
    @leagues << ["League", "Vinks"]
    leagues = League.includes(:country).order("country_id, level")
    leagues.each do |league|
      @leagues << ["[#{league.country.country_short}] #{league.name}", user.vinks.where("league_id = ?", league.id).count]
    end
    @leagues
  end

  def show_seasons(user)
    @seasons = Array.new
    @seasons << ["Season", "Vinks"]
    vinks = Vink.order("season").group(:season).count
    vinks.each do |key, value|
      @seasons << [key, value]
    end
    @seasons
  end

  def show_kickoffs(user)
    @kickoffs = Array.new
    @kickoffs << ["Kick-off", "Vinks"]
    vinks = Vink.order("kickoff").group(:kickoff).count
    vinks.each do |key, value|
      @kickoffs << [key, value]
    end
    @kickoffs
  end

end

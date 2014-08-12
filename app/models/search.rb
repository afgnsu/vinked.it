class Search

  def self.for(keyword)
    if is_number?(keyword)
      Vink.where('vink_nr > ? and vink_nr < ?', keyword.to_i - 4, keyword.to_i + 4).order("vink_date DESC")
    else
      keyword_search = "%#{keyword.downcase}%"

      clubs = Club.where('lower(name) LIKE ?', keyword_search).pluck(:id)
      leagues = League.where('lower(name) LIKE ?', keyword_search).pluck(:id)

      Vink.where('club_id IN (?)', clubs).order("vink_date DESC") +
        Vink.where('away_club_id IN (?)', clubs).order("vink_date DESC") +
        Vink.where('league_id IN (?)', leagues).order("vink_date DESC") +
        Vink.where('lower(ground) LIKE ?', keyword_search).order("vink_date DESC")
    end
  end

  private

  def self.is_number?(nr)
    true if Integer nr rescue false
  end
end
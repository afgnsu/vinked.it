class VinkSerializer < ActiveModel::Serializer
  attributes :vink_nr, :vink_date, :ground, :street, :city, :result, :season, :kickoff, :gate, :ticket,
             :countfor92, :rating, :club_id, :away_club_id, :user_id, :league_id, :programme_link, :ticket_link, 
             :latitude, :longitude
end
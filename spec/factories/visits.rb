FactoryGirl.define do
  factory :visit do
    visit_nr            1
    the92_nr            1
    visit_date          1.day.ago
    league_id           1
    club_id             1
    away_club_id        2
    ground              "Emirates Stadium"
    address              "Ashburton Grove"
    country             "England"
    result              "1-1"
    season              "2013-2014"
    kickoff             "15:00"
    gate                40000
    ticket_price        35.0
    countfor92          false
    rating_match        1
    rating_ground       1
    rating_atmosphere   1
    association         :user
  end
end

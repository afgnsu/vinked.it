FactoryGirl.define do
  factory :vink do
    vink_nr             1
    vink_date           1.day.ago
    away_club_id        2
    ground              "Emirates Stadium"
    street              "Ashburton Grove"
    city                "London"
    result              "1-1"
    season              "2013-2014"
    kickoff             "15:00"
    gate                40000
    ticket              35.0
    countfor92          false
    rating              7
    association         :user
    association         :club
  end
end
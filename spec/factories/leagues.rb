FactoryGirl.define do
  factory :league do
    name        "Premier League"
    name_short  "PL"
    level       1
    association :country
  end
end

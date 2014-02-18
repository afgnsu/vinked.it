FactoryGirl.define do
  factory :league do
    name        "Premier League"
    level       1
    association :country
  end
end

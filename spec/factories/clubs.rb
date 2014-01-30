FactoryGirl.define do
  factory :club do
    name        "Arsenal"
    association :league
  end
end

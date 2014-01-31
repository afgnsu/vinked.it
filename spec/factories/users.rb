FactoryGirl.define do
  sequence :email do |n|
    "user#{n}#{n}#{n}#{n}#{n}#{n}@factory#{n}#{n}.com"
  end

  factory :user do
    first_name        "John"
    last_name         "Van Arkelen"
    screen_name       "DutchAddick"
    location          "Eindhoven, The Netherlands"
    locale            "en"
    role              "employee"
    subscription      "basic"
    password          "password1"
    email
  end
end

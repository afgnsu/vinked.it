FactoryGirl.define do
  sequence :email do |n|
    "user#{n}#{n}#{n}#{n}#{n}#{n}@factory#{n}#{n}.com"
  end

  factory :user do
    first_name        "Piet"
    last_name         "Jansen"
    role              "employee"
    locale            "en"
    password          "password1"
    email
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content           "Mijn commentaar"
    commentable_id    1
    commentable_type  "Club"
    user_id           1
  end
end

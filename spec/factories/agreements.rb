
FactoryBot.define do
# user factory without associated posts
  factory :agreement do
    content { Faker::Lorem.sentence(6) }
    isAccepted { Faker::Boolean.boolean }
    isAgree { Faker::Boolean.boolean }
    avatar
    discussion
  end
end

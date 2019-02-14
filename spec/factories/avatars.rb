
FactoryBot.define do
  factory :avatar do
    name { Faker::Name.name }
    user
    discussion
  end
end

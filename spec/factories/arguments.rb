
FactoryBot.define do
# user factory without associated posts
  factory :argument do
    num { Faker::Number.between(1, 10) }
    content { Faker::Lorem.paragraphs(1) }
    avatar
    discussion
  end
end

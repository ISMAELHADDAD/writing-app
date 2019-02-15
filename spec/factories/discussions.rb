
FactoryBot.define do
  factory :discussion do
    topicTitle { Faker::Lorem.question }
    topicDescription { Faker::Lorem.paragraphs(1) }
    user

    after :create do |discussion|
      create_list :argument, 3, discussion: discussion   # has_many
      create_list :agreement, 3, discussion: discussion   # has_many
      create_list :avatar, 2, discussion: discussion   # has_many
    end
  end
end

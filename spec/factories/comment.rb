FactoryBot.define do
  factory :comment do
    user_id { 1 }
    post_id { 1 }
    content { Faker::Lorem.characters(number: 20) }
  end
end
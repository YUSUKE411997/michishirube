FactoryBot.define do
  factory :post do
    user_id { 1 }
    title { Faker::Lorem.characters(number: 5) }
    body { Faker::Lorem.characters(number: 20) }
    type { 1 }
  end
end
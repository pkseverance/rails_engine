FactoryBot.define do
  factory :item do
    name { Faker::Cannabis.strain }
    description { Faker::Cannabis.medical_use }
    unit_price { Faker::Number.between(from: 1.00, to: 100.00) }
  end
end

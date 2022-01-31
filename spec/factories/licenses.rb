FactoryBot.define do
  factory :license do
    key { Faker::Commerce::unique.promotion_code(digits: 6) }
  end
end

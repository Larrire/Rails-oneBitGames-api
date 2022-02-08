FactoryBot.define do
  factory :license do
    # key { Faker::Commerce::unique.promotion_code(digits: 6) }
    key { Faker::Lorem.characters(number: 15) }
    platform { :steam }
    status { :available }
    game
  end
end

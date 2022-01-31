FactoryBot.define do
  factory :license do
    key { Faker::Commerce::unique.promotion_code(digits: 6) }
    
    after :build do |license|
      license.game = create(:game)
    end
  end
end

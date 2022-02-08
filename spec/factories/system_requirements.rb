FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |number| "MyString #{number}" }
    operational_system { Faker::Computer.os }
    storage { "500gb" }
    processor { "AMD Ryzen 7" }
    memory { "2gb" }
    video_board { "AMD 1080" }
  end
end

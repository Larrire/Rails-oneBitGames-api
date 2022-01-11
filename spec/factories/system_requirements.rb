FactoryBot.define do
  factory :system_requirement do
    sequence(name) { |number| "Basic #{number}" }
    operational_system { Faker::Computer.os }
    storage { "50gb" }
    processor { "AMD Ryzen 7" }
    memory { "4gb" }
    video_board { "GeForce GTX 1050" }
  end
end

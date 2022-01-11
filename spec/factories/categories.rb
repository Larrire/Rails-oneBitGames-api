FactoryBot.define do
  factory :category do
    sequence(:name) { |number| "MyString #{number}" }
  end
end   

FactoryBot.define do
  factory :coupon do
    code { "MyString" }
    status { 1 }
    discount_value { "9.99" }
    due_date { "2022-01-12 20:41:49" }
  end
end

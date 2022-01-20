json.coupons do
  json.array! @coupons, :code, :status, :discount_value, :due_date
end
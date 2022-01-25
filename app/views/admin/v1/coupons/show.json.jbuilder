json.coupon do
  json.(@coupon, :code, :status, :discount_value, :due_date)
end
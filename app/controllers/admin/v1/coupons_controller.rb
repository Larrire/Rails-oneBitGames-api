module Admin::V1
  class CouponsController < ApiController
    def index
      @coupons = Coupon.all
    end

    def coupon_params
      return {} unless params.present?
      params.permit(%i(
        code status discount_value due_date 
      ))
    end
  end
end

module Admin::V1
  class CouponsController < ApiController
    
    def index
      @coupons = Coupon.all
    end

    def create
      @coupon = Coupon.new
      @coupon.attributes = coupon_params
      save_coupon!
    end

    def update
      @coupon = Coupon.find(params[:id])
      @coupon.attributes = coupon_params
      @coupon.save!
    end

    def show
      @coupon = Coupon.find(params[:id])
    rescue
      render_error(message: 'Coupon not found')
    end

    private

    def coupon_params
      return {} unless params.has_key?(:coupon)
      params.require(:coupon).permit( %i(
        code status discount_value due_date 
      ))
    end

    def save_coupon!
      @coupon.save!
      render :show
    rescue
      render_error(fields: @coupon.errors.messages)
    end

  end
end

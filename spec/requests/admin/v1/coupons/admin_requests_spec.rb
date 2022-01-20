require 'rails_helper'

RSpec.describe "Admin::V1::CouponsController as :admin", type: :request do

  context "GET /coupons" do
    let!(:coupons) { create_list(:coupon, 5) }
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/coupons" }

    it "returns all Coupons" do
      get url, headers: auth_header(user)
      expect(body_json['coupons']).to contain_exactly *coupons.as_json(except: %i(id created_at updated_at))
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /coupons" do
  end

  context "GET /coupons/:id" do
  end

  context "PATCH /coupons/:id" do
  end

  context "DELETE /coupons/:id" do
  end

end
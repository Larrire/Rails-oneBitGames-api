require 'rails_helper'

RSpec.describe "Admin::V1::CouponsController as :admin", type: :request do
  let(:user) { create(:user) }

  context "GET /coupons" do
    let!(:coupons) { create_list(:coupon, 5) }
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
    let(:url) { "/admin/v1/coupons" }

    context "with valid params" do
      let(:coupon_params) { {coupon: attributes_for(:coupon)}.to_json }

      it "adds a new Coupon" do
        expect do
          post url, headers: auth_header(user), params: coupon_params
        end.to change(Coupon, :count).by(1)
      end

      it "returns last added Coupon" do
        post url,  headers: auth_header(user), params: coupon_params
        expected_coupon = Coupon.last.as_json(except: %i(created_at updated_at))
        expect(body_json['coupon']).to eq expected_coupon
      end

      it "returns success status" do
        post url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil) }.to_json
      end

      it "does not add a new Coupon" do
        expect do
          post url, headers: auth_header(user), params: coupon_invalid_params
        end.to_not change(Coupon, :count)
      end

      it "return error messages" do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('code')
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity) #422
      end
    end
  end

  context "GET /coupons/:id" do
    
    context "with a valid id" do
      let(:coupon) { create(:coupon) }
      let(:url) { "/admin/v1/coupons/#{coupon.id}" }

      it "returns requested Coupon" do
        get url, headers: auth_header(user)
        expect(body_json['coupon']).to eq coupon.as_json(only: %i(id code status discount_value due_date))
      end

      it "returns success status" do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context "with an invalid id" do
      let(:url) { "/admin/v1/coupons/#{10000}" }

      it "does not return requested coupon" do
        get url, headers: auth_header(user)
        expect(body_json['coupon']).to_not be_present
      end

      it "returns error messages" do
        get url, headers: auth_header(user)
        expect(body_json['errors']['message']).to eq "Coupon not found"
      end

      it "returns unprocessable_entity status" do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:unprocessable_entity) #422     
      end
    end
  end

  context "PATCH /coupons/:id" do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    context "with valid params" do
      let(:new_code) { "999999" }
      let(:coupon_params) { {coupon: {code: new_code}}.to_json }

      it "updates the Coupon" do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect(coupon.code).to eq new_code
      end

      it "returns updated Coupon" do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect(body_json['coupon']).to eq coupon.as_json(except: %i(created_at updated_at))
      end

      it "returns success status" do
        patch url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil) }.to_json
      end
      
      it "does not update Coupon" do
        old_code = coupon.code
        patch url, headers: auth_header(user), params: coupon_invalid_params
        coupon.reload
        expect(coupon.code).to eq old_code
      end

      it "returns error message" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('code')
      end

      it "returns unprocessable_entity status" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity) #422
      end
    end
  end

  context "DELETE /coupons/:id" do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }
    
    it "deletes coupon" do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Coupon, :count).by(-1)
    end

    it "returns no_content status" do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it "does not return any body content" do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end
  end

end
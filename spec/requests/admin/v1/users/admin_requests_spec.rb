require 'rails_helper'

RSpec.describe "Admin::V1::Users as :admin", type: :request do
  let(:requestUser) { create(:user) }

  context "GET /users" do
    let(:url) { "/admin/v1/users" }
    let(:usersList) { create_list(:user, 5) }.to_json

    it "returns all users" do
      get url, headers: auth_header(requestUser)
      expect(body_json['users']).eq usersList
    end

    it "returns success status" do
      get url, headers: auth_header(requestUser)
      expect(response).to have_http_status(:ok)
    end
  end

end
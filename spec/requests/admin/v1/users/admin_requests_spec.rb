require 'rails_helper'

RSpec.describe "Admin::V1::Users as :admin", type: :request do
  let(:requestUser) { create(:user) }

  context "GET /users" do
    let(:url) { "/admin/v1/users" }
    let!(:usersList) { create_list(:user, 5) }

    it "returns all users" do
      get url, headers: auth_header(requestUser)
      allUsers = User.all
      expect(body_json['users']).to contain_exactly *allUsers.as_json(only: %i(name email profile))
    end

    it "returns success status" do
      get url, headers: auth_header(requestUser)
      expect(response).to have_http_status(:ok)
    end
  end #GET

  context "POST /users" do

    context "with valid params" do

      it "adds a new User" do

      end

      it "returns last added User" do

      end

      it "returns success status" do

      end

    end #valid-params

    context "with invalid params" do

      it "does not add a new user" do

      end

      it "returns errors messages" do

      end

      it "returns unprocessable_entity status" do

      end

    end #invalid-params

  end #POST

end
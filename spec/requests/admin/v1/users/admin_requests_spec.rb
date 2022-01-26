require 'rails_helper'

RSpec.describe "Admin::V1::Users as :admin", type: :request do
  let!(:requestUser) { create(:user) }

  context "GET /users" do
    let(:url) { "/admin/v1/users" }
    let!(:usersList) { create_list(:user, 5) }

    it "returns all users" do
      get url, headers: auth_header(requestUser)
      allUsers = User.all
      expect(body_json['users']).to contain_exactly *allUsers.as_json(only: %i(id name email profile))
    end

    it "returns success status" do
      get url, headers: auth_header(requestUser)
      expect(response).to have_http_status(:ok)
    end
  end #GET

  context "POST /users" do
    let(:url) { "/admin/v1/users" }

    context "with valid params" do
      let(:user_params) { {user: attributes_for(:user)}.to_json }

      it "adds a new User" do
        expect do
          post url, headers: auth_header(requestUser), params: user_params
        end.to change(User, :count).by(1)
      end

      it "returns last added User" do
        post url, headers: auth_header(requestUser), params: user_params
        expected_user = User.last.as_json(only: %i(id name email profile))
        expect(body_json['user']).to eq expected_user
      end

      it "returns success status" do
        post url, headers: auth_header(requestUser), params: user_params
        expect(response).to have_http_status(:ok)
      end

    end #valid-params

    context "with invalid params" do
      let(:user_invalid_params) { {user: attributes_for(:user, name: nil)}.to_json }

      it "does not add a new user" do
        expect do
          post url, headers: auth_header(requestUser), params: user_invalid_params
        end.to_not change(User, :count)
      end

      it "returns errors messages" do
        post url, headers: auth_header(requestUser), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(requestUser), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end #invalid-params
  end #POST

  context "GET /users/:id" do

    context "with a valid id" do
      let(:url) { "/admin/v1/users/#{requestUser.id}" }

      it "returns requested User" do
        get url, headers: auth_header(requestUser)
        expected_user = requestUser.as_json(only: %i(id name email profile))
        expect(body_json['user']).to eq expected_user
      end

      it "returns success status" do
        get url, headers: auth_header(requestUser)
        expect(response).to have_http_status(:ok)
      end
    end #valid-id

    context "with an invalid id" do
      let(:url) { "/admin/v1/users/99999" }

      it "does not return requested User" do
        get url, headers: auth_header(requestUser)
        expect(body_json['user']).to_not be_present
      end

      it "returns error messages" do
        get url, headers: auth_header(requestUser)
        expect(body_json['errors']['message']).to eq 'User not found'
      end

      it "returns unprocessable_entity status" do
        get url, headers: auth_header(requestUser)
        expect(response).to have_http_status(:unprocessable_entity) #422
      end

    end #invalid-id
    
  end #GET

end
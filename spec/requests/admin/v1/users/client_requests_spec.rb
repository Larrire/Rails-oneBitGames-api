require 'rails_helper'

RSpec.describe "Admin::V1::Users as :client", type: :request do
  let(:requestUser) { create(:user, profile: :client) }

  context "GET /users" do
    let(:url) { "/admin/v1/users" }
    let(:users) { create_list(:user, 5) }

    before(:each) { get url, headers: auth_header(requestUser) }
    include_examples "forbidden access"
  end #GET

  context "POST /users" do
    let(:url) { "/admin/v1/users" }

    before(:each) { post url, headers: auth_header(requestUser) }
    include_examples "forbidden access"
  end #POST

  context "GET /users/:id" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/users/#{user.id}" }

    before(:each) { get url, headers: auth_header(requestUser) }

    include_examples "forbidden access"
  end #GET

  context "PATCH /users" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/users/#{user.id}" }

    before(:each) { patch url, headers: auth_header(requestUser) }
    include_examples "forbidden access"
  end #PATCH

  context "DELETE /users" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/users/#{user.id}" }

    before(:each) { delete url, headers: auth_header(requestUser) }
    include_examples "forbidden access"
  end #DELETE
  
end
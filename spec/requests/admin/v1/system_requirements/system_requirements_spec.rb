require 'rails_helper'

RSpec.describe "Admin::V1::SystemRequirements", type: :request do
  context "GET /system_requirements" do
    let!(:system_requirements) { create_list(:system_requirement, 5) }
    let(:url) { "/admin/v1/system_requirements" }
    let(:user) { create(:user) }

    it "returns all system requirements" do
      get url, headers: auth_header(user)
      expect(body_json['system_requirements']).to contain_exactly *system_requirements.as_json(only: %i(id name))
    end

    it "returns status code :ok" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /system_requirements" do
  end

  context "PATCH /system_requirements/:id" do
  end

  context "DELETE /system_requirements/:id" do
  end
end
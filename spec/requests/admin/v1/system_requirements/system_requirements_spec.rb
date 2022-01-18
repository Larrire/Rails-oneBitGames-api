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

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /system_requirements" do
    let(:url) { "/admin/v1/system_requirements" }
    let(:user) { create(:user) }

    context "with valid params" do
      let(:system_requirement_params) { {system_requirement: attributes_for(:system_requirement)}.to_json }

      it "adds a new SystemRequirement" do
        expect do
          post url, headers: auth_header(user), params: system_requirement_params
        end.to change(SystemRequirement, :count).by(1)
      end

      it "returns last added SystemRequirement" do
        post url, headers: auth_header(user), params: system_requirement_params
        expected_system_requirement = SystemRequirement.last.as_json( only: %i(id name) )
        expect(body_json['system_requirement']).to eq expected_system_requirement
      end

      it "returns success status" do
        post url, headers: auth_header(user), params: system_requirement_params
        expect(response).to have_http_status(:ok)
      end
    end



  end

  context "PATCH /system_requirements/:id" do
  end

  context "DELETE /system_requirements/:id" do
  end
end
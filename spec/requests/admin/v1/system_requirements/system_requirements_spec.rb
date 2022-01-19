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
  end # GET

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
        expected_system_requirement = SystemRequirement.last.as_json( only: %i(id name operational_system storage processor memory video_board) )
        expect(body_json['system_requirement']).to eq expected_system_requirement
      end

      it "returns success status" do
        post url, headers: auth_header(user), params: system_requirement_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:invalid_system_requirement_params) { {
        name: nil,
        operational_system: nil,
        storage: nil,
        processor: nil,
        memory: nil,
        video_board: nil,
      }.to_json}

      it "does not add a new SystemRequirement" do
        expect do
          post url, headers: auth_header(user), params: invalid_system_requirement_params
        end.to_not change(SystemRequirement, :count)
      end

      it "returns errors messages" do
        post url, headers: auth_header(user), params: invalid_system_requirement_params
        expect(body_json['errors']['fields'].keys).to eq ['name', 'operational_system', 'storage', 'processor', 'memory', 'video_board']
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: invalid_system_requirement_params
        expect(response).to have_http_status(:unprocessable_entity) # 422
      end

    end

  end # POST

  context "PATCH /system_requirements/:id" do
    let(:system_requirement) { create(:system_requirement) }
    let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }
    let(:user) { create(:user) }
    
    context "with valid params" do
      let(:new_attributes) {{
        name: 'New name',
        operational_system: 'New oparational system',
        storage: 'New storagessss',
        processor: 'New processor',
        memory: 'New memory',
        video_board: 'New video board'
      }.to_json}

      it "updates system_requirement" do
        patch url, headers: auth_header(user), params: new_attributes
        system_requirement.reload
        reloaded_attributes = system_requirement.to_json(except: %i(id created_at updated_at))
        expect(reloaded_attributes).to eq new_attributes
      end

      it "returns updated system_requirement" do
        patch url, headers: auth_header(user), params: new_attributes
        system_requirement.reload
        expected_system_requirement = system_requirement.as_json(except: %i(created_at updated_at))
        expect(body_json['system_requirement']).to eq expected_system_requirement
      end

      it "returns success status" do
        patch url, headers: auth_header(user), params: new_attributes
        expect(response).to have_http_status(:ok) 
      end

    end

    context "with invalid params" do

    end
    
  end # PATCH

  context "DELETE /system_requirements/:id" do
  end # DELETE
end
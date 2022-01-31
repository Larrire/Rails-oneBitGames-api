require 'rails_helper'


RSpec.describe 'Admin::V1::Licenses as :admin', type: :request do
  let(:user) { create(:user) }

  context "GET /licenses" do
    let!(:licenses) { create_list(:license, 10) }
    let(:url) { "/admin/v1/licenses" }

    it "tests" do
      get url, headers: auth_header(user)
      expect(body_json['licenses'].length).to eq 10
    end
  end

  context "POST /licenses" do

  end

  context "GET /licenses/:id" do

  end

  context "PATCH /licenses/:id" do

  end

  context "DELETE /licenses/:id" do

  end

end
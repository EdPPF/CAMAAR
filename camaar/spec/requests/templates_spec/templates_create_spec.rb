require 'rails_helper'

RSpec.describe "Templates", type: :request do
  let(:valid_attributes) { { nome: "Template Example" } }
  let(:invalid_attributes) { { nome: "" } }
  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Template and redirects to the created template" do
        expect {
          post templates_url, params: { template: valid_attributes }
        }.to change(Template, :count).by(1)
        expect(response).to redirect_to(templates_url)
      end
    end
    context "with invalid parameters" do
      it "does not create a new Template and returns an unprocessable entity status" do
        expect {
          post templates_url, params: { template: invalid_attributes }
        }.to change(Template, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

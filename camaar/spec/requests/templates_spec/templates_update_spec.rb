require 'rails_helper'

RSpec.describe "Templates", type: :request do
  let(:valid_attributes) { { nome: "Template Example" } }
  let(:template) { Template.create!(valid_attributes) }
  let(:new_valid_attributes) { { nome: "New Template Example" } }
  let(:invalid_attributes) { { nome: "" } }
  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested template" do
        patch template_url(template), params: { template: new_valid_attributes }
        template.reload
        expect(template.nome).to eq("New Template Example")
      end
    end
    context "with invalid parameters" do
      it "returns an unprocessable entity status" do
        patch template_url(template), params: { template: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

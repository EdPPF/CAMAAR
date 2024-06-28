require 'rails_helper'

RSpec.describe "Templates", type: :request do
  let(:valid_attributes) { { nome: "Template Example" } }
  let(:invalid_attributes) { { nome: "" } }
  let(:new_valid_attributes) { { nome: "New Template Example" } }
  let(:template) { Template.create!(valid_attributes) }

  describe "GET /index" do
    it "retorna um valor com sucesso" do
      get templates_url
      expect(response).to be_successful
    end
  end
  describe "GET /show" do
    it "retorna um valor com sucesso" do
      get template_url(template)
      expect(response).to be_successful
    end
  end
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
  describe "DELETE /destroy" do
    it "destroys the requested template and redirects to the templates list" do
      expect {
        delete template_url(template)
      }.to change(Template, :count).by(0)
      expect(response).to redirect_to(templates_url)
    end
  end
end

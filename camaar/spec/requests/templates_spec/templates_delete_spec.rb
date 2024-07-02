require 'rails_helper'

RSpec.describe "Templates", type: :request do
  let(:valid_attributes) { { nome: "Template Example" } }
  let(:template) { Template.create!(valid_attributes) }
  describe "DELETE /destroy" do
    it "destroys the requested template and redirects to the templates list" do
      expect {
        delete template_url(template)
      }.to change(Template, :count).by(0)
      expect(response).to redirect_to(templates_url)
    end
  end
end

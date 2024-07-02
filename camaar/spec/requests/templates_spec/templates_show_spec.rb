require 'rails_helper'

RSpec.describe "Templates", type: :request do
  let(:valid_attributes) { { nome: "Template Example" } }
  let(:template) { Template.create!(valid_attributes) }
  describe "GET /show" do
    it "retorna um valor com sucesso" do
      get template_url(template)
      expect(response).to be_successful
    end
  end
end

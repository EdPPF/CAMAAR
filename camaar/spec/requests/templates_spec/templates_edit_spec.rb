require 'rails_helper'

RSpec.describe "Templates", type: :request do
  let(:template) { Template.create!(nome: "Template Example") }

  describe "GET /edit" do
    it "retorna uma resposta bem-sucedida" do
      get edit_template_url(template)
      expect(response).to be_successful
    end
  end
end

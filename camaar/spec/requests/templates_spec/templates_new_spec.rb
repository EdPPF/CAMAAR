require 'rails_helper'

RSpec.describe "Templates", type: :request do
  describe "GET /new" do
    it "retorna uma resposta bem-sucedida" do
      get new_template_url
      expect(response).to be_successful
    end
  end
end

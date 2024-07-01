require 'rails_helper'

RSpec.describe "Templates", type: :request do
  describe "GET /index" do
    it "retorna um valor com sucesso" do
      get templates_url
      expect(response).to be_successful
    end
  end
end

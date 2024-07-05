require 'rails_helper'

RSpec.describe "Formularios", type: :request do
  describe "GET /" do
    # Nome, Turma, Template
    let (:template) { create(:template) }
    let (:turma) { create(:turma) }
    before do
      create(:formulario, nome:"Avaliação A", turma:turma, template:template)
      create(:formulario, nome:"Avaliação B", turma:turma, template:template)
    end

    context "quando existem formulários" do
      before do
        get "/formularios", as: :json
      end

      it "retorna status 200 OK" do
        expect(response).to have_http_status(200)
      end
    end
  end
end

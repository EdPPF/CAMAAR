require 'rails_helper'

RSpec.describe "Formularios", type: :request do
  describe "GET /:id" do
    let (:template) { create(:template) }
    let (:turma) { create(:turma) }
    let (:formulario) { create(:formulario, nome:"Avaliação A", turma:turma, template:template) }
    let(:formulario_params) do
      attributes_for(:formulario)
    end

    context "quando o formulário existe" do
      before do
        get "/formularios/#{formulario.id}", params: { formulario: formulario_params }, as: :json
      end

      it "retorna status 200 OK" do
        expect(response).to have_http_status(200)
      end
    end

    context "quando o formulário não existe" do
      it "retorna status 404 Not Found" do
        get "/formularios/0", params: { formulario: formulario_params }
        expect(response).to have_http_status(404)
      end
    end
  end
end

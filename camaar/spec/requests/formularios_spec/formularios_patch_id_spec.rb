require 'rails_helper'

RSpec.describe "Formularios", type: :request do
  describe "PATCH /:id" do
    let (:template) { create(:template) }
    let (:turma) { create(:turma) }
    let (:formularioA) { create(:formulario, nome:"Avaliação A", turma:turma, template:template) }
    let (:formularioB) { create(:formulario, nome:"Avaliação B", turma:turma, template:template) }
    let(:formulario_params) do
      attributes_for(:formulario)
    end

    context "quando os parâmetros estão ok" do
      before do
        patch "/formularios/#{formularioA.id}", params: { formulario: { nome: "Avaliação C" } }, as: :json
      end

      it "retorna status 200 OK" do
        expect(response).to have_http_status(200)
      end

      it "retorna o formulário atualizado" do
        json_response = JSON.parse(response.body)
        expect(json_response.except('created_at', 'updated_at', 'id')).to eq(
          {"nome"=>"Avaliação C", "turma_id"=>1, "template_id"=>1}
        )
      end
    end

    context "quando os parâmetros são inválidos" do
      it "retorna HTTP status bad request" do
        patch "/formularios/#{formularioB.id}", params: { formulario: { nome:nil } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end

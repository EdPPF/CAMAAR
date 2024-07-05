require 'rails_helper'

RSpec.describe "Formularios", type: :request do
  describe "POST /" do
    let (:template) { create(:template, nome:"Template A") }
    let (:materia) { create(:materia, codigo:"TST0097", nome:"BANCOS DE TESTES") }
    let (:turma) { create(:turma, codigo:"TA", semestre:"2021.2", horario:"35T45", materia:materia)}
    let (:formulario_params) do
      { nome: "Avaliação A", turma_id: turma.id, template_id: template.id }
    end
    before do
      post "/formularios", params: { formulario: formulario_params }, as: :json
    end

    context "quando os parâmetros são válidos" do
      it "retorna status 201 Created" do
        expect(response).to have_http_status(201)
      end

      it "retorna o formulário criado" do
        json_response = JSON.parse(response.body)
        expect(json_response.except('created_at', 'updated_at', 'id')).to eq(
          {"nome"=>"Avaliação A", "turma_id"=>1, "template_id"=>1}
        )
      end
    end
    context "quando os parametros são invalidos" do
      it "retorna bad request" do
        post "/formularios", params: { formulario: nil }, as: :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

end

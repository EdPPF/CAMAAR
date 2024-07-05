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

  describe "DELETE /:id" do
    let (:template) { create(:template) }
    let (:turma) { create(:turma) }
    let (:formulario) { create(:formulario, nome:"Avaliação A", turma:turma, template:template) }

    context "quando o formulário existe" do
      it "retorna HTTP status ok" do
        delete "/formularios/#{formulario.id}", as: :json
        expect(response).to have_http_status(200)
      end
    end

    context "quando o formulário não existe" do
      it "retorna HTTP status not_found" do
        delete "/formularios/0"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "Exportar resultados" do
    let (:template) { create(:template) }
    let (:turma) { create(:turma) }
    let (:formulario) { create(:formulario, nome:"Avaliação A", turma:turma, template:template) }

    context "GET /resultados" do
      it "retorna HTTP status ok" do
        get resultados_formularios_path
        expect(response).to be_successful
      end
    end
    context "GET /export_csv" do
      it "retorna HTTP status ok" do
        get export_csv_formulario_path(formulario.id), params: {format: :csv}
        expect(response).to be_successful
      end
    end
  end


  describe "GET responder formulario" do
    let (:formulario) { create(:formulario) }
    context "mostrar formularios pendentes" do
      it "retorna status 200 ok" do
        user = create(:user)
        sign_in user
        get show_pending_formularios_path
        expect(response).to have_http_status(200)
      end
    end
    context "usuario nao esta logado entao nao da para ver os formularios pendentes" do
      it "retorna status nao processado" do
        get show_pending_formularios_path
        expect(response).to redirect_to(formularios_path)
        expect(flash[:notice]).to eq("Um erro ocorreu")
      end
    end
    context "pagina de responder formulario" do
      it "retorna status 200 ok" do
        get responder_formulario_path(formulario.id)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "envio de formularios" do
    context "abrir pagina para criar form" do
      it "retorna HTTP status ok" do
        get send_form_formularios_path
        expect(response).to be_successful
      end
    end
  end


end

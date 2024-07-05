require 'rails_helper'

RSpec.describe "Formularios", type: :request do

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

end

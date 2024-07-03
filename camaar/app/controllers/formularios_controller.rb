require 'csv'

class FormulariosController < ApplicationController
    def index
        formularios = Formulario.all
        # mudei de render json: formularios, status: :ok para render json: formularios, status: :ok
        respond_with_formulario(formularios)
    end

    def show
        formulario = find_formulario
         # render json: formulario, status: :ok
        respond_with_formulario(formulario)
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def create
        formulario = Formulario.new(formulario_params)
        formulario.save!
        respond_with_formulario(formulario, status: :created)
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def update
        formulario = find_formulario
        if formulario.update(formulario_params)
            handle_success(formulario)
        else
            handle_failure(formulario)
        end
    end

    def destroy
        formulario = find_formulario
        formulario.destroy!
        # render json: { message: "Formulario deleted." }, status: :ok
        respond_with_formulario(formulario)
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def export_csv
        formularios = Formulario.all

        respond_to do |format|
          format.csv { send_data generate_csv(formularios), filename: "formularios-#{Date.today}.csv" }
        end
      end

    private

    def formulario_params
        params.require(:formulario).permit(:nome, :turma_id, :template_id)
    end

    def generate_csv(formularios)
        CSV.generate(headers: true) do |csv|
          csv << ['ID', 'Nome', 'Criado em', 'Atualizado em']

          formularios.each do |formulario|
            csv << [formulario.id, formulario.nome, formulario.created_at, formulario.updated_at]
          end
        end
    end

    def find_formulario
        Formulario.find(params[:id])
    end

    def respond_with_formulario(formulario, status: :ok)
        respond_to do |format|
            format.html
            format.json { render json: formulario, status: status}
        end
    end

    # Similar ao respond_with_formulario, mas com a diferença de que ele redireciona para a página de formularios
    def handle_success(formulario)
        respond_to do |format|
            format.html { redirect_to formularios_path, notice: "#{formulario.nome} updated." }
            format.json { render json: formulario, status: :ok }
        end
    end

    def handle_failure(formulario)
        flash.now[:alert] = "#{formulario.nome} could not be updated: " + formulario.errors.full_messages.join(", ")
        render 'edit', status: :bad_request
    end
end

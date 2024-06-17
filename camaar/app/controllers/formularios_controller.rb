class FormulariosController < ApplicationController
    def index
        formularios = Formulario.all
        render json: formularios, status: :ok
    end

    def show
        formulario = Formulario.find(params[:id])
        render json: formulario, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def create
        formulario = Formulario.new(formulario_params)
        formulario.save!
        render json: formulario, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def update
        formulario = Formulario.find(params[:id])
        formulario.update!(formulario_params)
        render json: formulario, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def delete
        formulario = Formulario.find(params[:id])
        formulario.destroy!
        render json: { message: "Formulario deleted." }, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    private

    def formulario_params
        params.require(:formulario).permit(:nome, :turma_id, :template_id)
    end
end

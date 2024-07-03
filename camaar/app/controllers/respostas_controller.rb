class RespostasController < ApplicationController
  def index
    respostas = Resposta.all
    render json: respostas, status: :ok
  end

  def show
    resposta = Resposta.find(params[:id])
    render json: resposta, status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end

  def create
    resposta = Resposta.new(resposta_params)
    resposta.save!
    render json: resposta, status: :created
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  def bulk_create
    if current_user
      @formulario = Formulario.find(params.require(:template).require(:formulario_id))
      params.require(:template).require(:respostas).each do |key, resposta_param|
        resposta_param = resposta_param.permit(:questao_id, :formulario_id, :texto)
        Resposta.create!(resposta_param)
      end
      current_user.formularios << @formulario
      respond_to do |format|
        format.html { redirect_to show_pending_formularios_path, notice: "Formulario respondido" }
        format.json { render json: "Formualrio respondido", status: :created }
      end
    end
  end

  def update
    resposta = Resposta.find(params[:id])
    resposta.update!(resposta_params)
    render json: resposta, status: :ok
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  def delete
    resposta = Resposta.find(params[:id])
    resposta.destroy!
    render json: { message: "Resposta deleted." }, status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end

  private

  def resposta_params
    params.require(:resposta).permit(:texto, :formulario_id, :questao_id)
  end
end

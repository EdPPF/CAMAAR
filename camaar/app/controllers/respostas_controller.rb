##
# Responsável por gerenciar as requisições referentes a Resposta.

class RespostasController < ApplicationController

  ##
  # Lista todas as respostas cadastradas no sistema.
  #
  # Retorno:: renderiza um JSON com todas as respostas e status 200.

  def index
    respostas = Resposta.all
    render json: respostas, status: :ok
  end


  ##
  # Mostra uma resposta específica.
  #
  # Parâmetros::
  # id: int - o id da resposta a ser mostrada.
  #
  # Retorno:: renderiza um JSON com a resposta e status 200.
  # - Se a resposta não existir, renderiza um JSON com a mensagem de erro e status 404.

  def show
    resposta = Resposta.find(params[:id])
    render json: resposta, status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end


  ##
  # Cria uma nova resposta.
  #
  # Parâmetros::
  # resposta: Hash - os atributos da resposta a ser criada.
  #
  # Retorno:: renderiza um JSON com a resposta criada e status 201.
  # - Se os atributos da resposta forem inválidos, renderiza um JSON com a mensagem de erro e status 400.

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

  
  ##
  # Atualiza uma resposta específica.
  #
  # Parâmetros::
  # id: int - o id da resposta a ser atualizada.
  # resposta: Hash - os atributos da resposta a ser atualizada.
  #
  # Retorno:: renderiza um JSON com a resposta atualizada e status 200.
  # - Se a resposta não existir, renderiza um JSON com a mensagem de erro e status 404.
  
  def update
    resposta = Resposta.find(params[:id])
    resposta.update!(resposta_params)
    render json: resposta, status: :ok
  rescue StandardError => e
    render json: e, status: :bad_request
  end


  ##
  # Deleta uma resposta específica.
  #
  # Parâmetros::
  # id: int - o id da resposta a ser deletada.
  #
  # Retorno:: renderiza um JSON com a mensagem de sucesso e status 200.
  # - Se a resposta não existir, renderiza um JSON com a mensagem de erro e status 404.

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

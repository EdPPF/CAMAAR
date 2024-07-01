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
  # Parâmetros:: o ID da resposta, passado pela rota.
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
  # Parâmetros:: os atributos da resposta, na requisição.
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

  ##
  # Atualiza uma resposta existente.
  #
  # Parâmetros:: os atributos da resposta, na requisição.
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
  # Deleta uma resposta existente.
  #
  # Parâmetros:: o ID da resposta, passado pela rota.
  #
  # Retorno:: renderiza um JSON com a mensagem de confirmação e status 200.
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

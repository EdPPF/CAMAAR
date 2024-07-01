##
# Responsável por gerenciar as requisições referentes a Questao.

class QuestoesController < ApplicationController

  ##
  # Lista todas as questões cadastradas no sistema.
  #
  # Retorno:: renderiza um JSON com todas as questões e status 200.

  def index
    questoes = Questao.all
    render json: questoes, status: :ok
  end

  ##
  # Mostra uma questão específica.
  #
  # Parâmetros:: o ID da questão, passado pela rota.
  #
  # Retorno:: renderiza um JSON com a questão e status 200.
  # - Se a questão não existir, renderiza um JSON com a mensagem de erro e status 404.

  def show
    questao = Questao.find(params[:id])
    render json: questao, status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end

  ##
  # Cria uma nova questão.
  #
  # Parâmetros:: os atributos da questão, na requisição.
  #
  # Retorno:: renderiza um JSON com a questão criada e status 201.
  # - Se os atributos da questão forem inválidos, renderiza um JSON com a mensagem de erro e status 400.

  def create
    questao = Questao.new(questao_params)
    questao.save!
    render json: questao, status: :created
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  ##
  # Atualiza uma questão existente.
  #
  # Parâmetros:: os atributos da questão, na requisição.
  #
  # Retorno:: renderiza um JSON com a questão atualizada e status 200.
  # - Se a questão não existir, renderiza um JSON com a mensagem de erro e status 404.

  def update
    questao = Questao.find(params[:id])
    questao.update!(questao_params)
    render json: questao, status: :ok
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  ##
  # Deleta uma questão existente.
  #
  # Parâmetros:: o ID da questão, passado pela rota.
  #
  # Retorno:: renderiza um JSON com a mensagem de sucesso e status 200.
  # - Se a questão não existir, renderiza um JSON com a mensagem de erro e status 404.
  def delete
    questao = Questao.find(params[:id])
    questao.destroy!
    render json: { message: "Questao deleted." }, status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end

  private

  def questao_params
    params.require(:questao).permit(:texto, :formulario_id, :template_id)
  end
end

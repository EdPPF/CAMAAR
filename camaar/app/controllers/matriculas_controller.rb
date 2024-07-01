##
# Responsável por gerenciar as matrículas cadastradas no sistema.
class MatriculasController < ApplicationController

  ##
  # Lista todas as matrículas cadastradas no sistema.
  #
  # Retorno:: renderiza um JSON com todas as matrículas e status 200.

  def index
    matriculas = Matricula.all
    render json: matriculas, status: :ok
  end

  ##
  # Cria uma nova matrícula.
  #
  # Parâmetros:: os atributos da matrícula, na requisição.
  #
  # Retorno:: renderiza um JSON com a matrícula criada e status 201.
  # - Se os atributos da matrícula forem inválidos, renderiza um JSON com a mensagem de erro e status 400.

  def create
    matricula = Matricula.new(matricula_params)
    matricula.save!
    render json: matricula, status: :created
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  ##
  # Deleta uma matrícula específica.
  #
  # Parâmetros:: o ID da matrícula, passado pela rota.
  #
  # Retorno:: renderiza um JSON com a mensagem de sucesso e status 200.
  # - Se a matrícula não existir, renderiza um JSON com a mensagem de erro e status 404.

  def delete
    matricula = Matricula.find(params[:id])
    matricula.destroy!
    render json: { message: "Matricula Deleted." }, status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end

  private

  def matricula_params
    params.require(:matricula).permit(:turma_id, :user_id)
  end
end

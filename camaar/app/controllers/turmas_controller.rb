##
# Responsável por gerenciar as requisições referentes a turmas.

class TurmasController < ApplicationController

  ##
  # Lista todas as turmas cadastradas no sistema.
  #
  # Retorno:: renderiza um JSON com todas as turmas e status HTTP 200 (OK).

  def index
    turmas = Turma.all
    render json: turmas, status: :ok
  end

  ##
  # Cria uma nova turma.
  #
  # Parâmetros:: os atributos da turma, na requisição.
  #
  # Retorno:: renderiza um JSON com a turma criada e status HTTP 201 (Created).

  def show
    turma = Turma.find(params[:id])
    render json: turma, status: :ok
  end

  private

  def turma_params
    params.require(:turma).permit(:codigo, :semestre, :horario, :materia_id)
  end
end

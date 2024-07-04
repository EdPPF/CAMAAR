##
# Responsável por gerenciar as requisições referentes a turmas.

class TurmasController < ApplicationController

  ##
  # Lista todas as turmas cadastradas no sistema.
  #
  # Retorno:: renderiza um JSON com todas as turmas e status 200.

  def index
    turmas = Turma.all
    render json: turmas, status: :ok
  end


  ##
  # Mostra uma turma específica.
  #
  # Parâmetros::
  # id: int - o id da turma a ser mostrada.
  #
  # Retorno:: renderiza um JSON com a turma e status 200.

  def show
    turma = Turma.find(params[:id])
    render json: turma, status: :ok
  end

  private

  def turma_params
    params.require(:turma).permit(:codigo, :semestre, :horario, :materia_id)
  end
end

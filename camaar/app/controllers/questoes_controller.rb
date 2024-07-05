##
# Responsável por gerenciar as requisições referentes a Questao.

class QuestoesController < ApplicationController

  ##
  # Lista todas as questões.
  #
  # Retorno:: renderiza um JSON com todas as questões e status 200.

  def index
    questoes = Questao.all
    render json: questoes, status: :ok
  end

  def new
    @questao = Questao.new({template_id: params[:id]})
  end
  
  
  ##
  # Mostra uma questão específica.
  #
  # Parâmetros::
  # id: int - o id da questão a ser mostrada.
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
  # Parâmetros::
  # questao: Hash - os atributos da questão a ser criada.
  #
  # Retorno:: renderiza um JSON com a questão criada e status 201.
  # - Se os atributos da questão forem inválidos, renderiza um JSON com a mensagem de erro e status 400.

  def create
    questao = Questao.new(questao_params)
    questao.save!
    respond_to do |format|
      format.html { redirect_to template_path(questao.template_id), notice: "Questao criada" }
      format.json { render json: questao, status: :created }
    end
  rescue StandardError => e
    render json: e, status: :bad_request
  end


  ##
  # Atualiza uma questão específica.
  #
  # Parâmetros::
  # id: int - o id da questão a ser atualizada.
  # questao: Hash - os atributos da questão a ser atualizada.
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
  # Deleta uma questão específica.
  #
  # Parâmetros::
  # id: int - o id da questão a ser deletada.
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

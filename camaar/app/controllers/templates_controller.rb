##
# Responsável por controlar as ações de CRUD de templates.

class TemplatesController < ApplicationController
  ##
  # Define o template a ser utilizado.

  before_action :set_template, only: [:show, :edit, :update, :destroy]


  ##
  # Lista todos os templates.
  #
  # Retorno:: renderiza a variável de instância @templates na view.

  def index #chama todos os itens
    @templates = Template.all
  end


  ##
  # Obtem um template específico e suas questões.

  def show
    @questaos = @template.questaos
  end


  ##
  # Renderiza a view de criação de um novo template.

  def new # abre uma nova instancia
    @template = Template.new
  end


  ##
  # Cria um novo template.
  #
  # Parâmetros::
  # template: Hash - os atributos do template a ser criado.
  #
  # Retorno:: redireciona para a página de templates e mostra uma mensagem de sucesso.
  # - Se os atributos do template forem inválidos, renderiza a view de criação com uma mensagem de erro.

  def create # Processo de criação no banco de dados
    @template = Template.new(template_params)
    if @template.save
      redirect_to templates_path, notice: "#{@template.nome} created."
    else
      flash[:alert] = "Template could not be created: " + @template.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end


  ##
  # TODO: Renderiza a view de edição de um template.
  def edit # Ediçao da instancia em caso
  end


  ##
  # Atualiza um template específico.
  #
  # Parâmetros::
  # id: int - o id do template a ser atualizado.
  # template: Hash - os atributos do template a ser atualizado.
  #
  # Retorno:: redireciona para a página de templates e mostra uma mensagem de sucesso.
  # - Se os atributos do template forem inválidos, renderiza a view de edição com uma mensagem de erro.

  def update # Atualização do template no banco de dados com a logistica
    if @template.update(template_params)
      redirect_to templates_path, notice: "#{@template.nome} updated."
    else
      flash.now[:alert] = "#{@template.nome} could not be updated: " + @template.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end


  ##
  # Deleta um template específico.
  #
  # Parâmetros::
  # id: int - o id do template a ser deletado.
  #
  # Retorno:: redireciona para a página de templates e mostra uma mensagem de sucesso.

  def destroy # Destroi o template em questao
    @template.destroy
    redirect_to templates_path, notice: "#{@template.nome} deleted."
  end

  private

  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:nome)
  end
end

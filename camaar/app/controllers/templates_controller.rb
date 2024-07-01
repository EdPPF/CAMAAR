##
# Responsável por controlar as ações de CRUD de templates.

class TemplatesController < ApplicationController

  ##
  # Mostra um template específico.
  #
  # Parâmetros:: o ID do template, passado pela rota.
  #
  # Retorno:: renderiza a variável de instânia @template na view, que contém o template a ser mostrado.

  def show
    @template = Template.find(params[:id])
  end

  ##
  # Lista todos os templates cadastrados no sistema.
  #
  # Retorno:: renderiza a variável de instância @templates na view, que contém todos os templates.

  def index
    @templates = Template.all
  end

  ##
  # Não utilizada:: cria uma instância de Template, mas não salva no banco de dados.

  def new
    @template = Template.new
  end

  ##
  # Cria um novo template.
  #
  # Parâmetros:: os atributos do template, na requisição.
  #
  # Retorno:: redireciona para a lista de templates, com uma mensagem de sucesso.
  # - Se os atributos do template forem inválidos, renderiza a view de criação, com uma mensagem de erro.

  def create
    @template = Template.new(template_params)

    if @template.save
      redirect_to templates_path, notice: "#{@template.nome} created."
    else
      flash[:alert] = "Template could not be created: " + @template.errors.full_messages.join(", ")
      render 'new', status: :unprocessable_entity
    end
  end

  ##
  # Não utilizada:: procura por um template específico para editar.

  def edit
    @template = Template.find params[:id]
  end

  ##
  # Atualiza um template existente.
  #
  # Parâmetros:: o ID do template e os atributos do template, na requisição.
  #
  # Retorno:: redireciona para a lista de templates, com uma mensagem de sucesso.
  # - Se os atributos do template forem inválidos, renderiza a view de edição, com uma mensagem de erro.

  def update
    @template = Template.find(params[:id])
    if @template.update(template_params)
      redirect_to templates_path, notice: "#{@template.nome} updated."
    else
      flash.now[:alert] = "#{@template.nome} could not be updated: " + @template.errors.full_messages.join(", ")
      render 'edit', status: :unprocessable_entity
    end
  end

  ##
  # Deleta um template existente.
  #
  # Parâmetros:: o ID do template, passado pela rota.
  #
  # Retorno:: redireciona para a lista de templates, com uma mensagem de sucesso.

  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    redirect_to templates_path, :notice => "#{@template.nome} deleted."
  end

  private

  def template_params
    params.require(:template).permit(:nome)
  end
end

class TemplatesController < ApplicationController
  #define o :set_template antes das funçoes abaixo
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  def index #chama todos os itens
    @templates = Template.all
  end

  def show # mostra o item de forma detalhada
  end

  def new # abre uma nova instancia
    @template = Template.new
  end

  def create # Processo de criação no banco de dados
    @template = Template.new(template_params)
    if @template.save
      redirect_to templates_path, notice: "#{@template.nome} created."
    else
      flash[:alert] = "Template could not be created: " + @template.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit # Ediçao da instancia em caso
  end

  def update # Atualização do template no banco de dados com a logistica
    if @template.update(template_params)
      redirect_to templates_path, notice: "#{@template.nome} updated."
    else
      flash.now[:alert] = "#{@template.nome} could not be updated: " + @template.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # Destroi o template em questao
    @template.destroy
    redirect_to templates_path, notice: "#{@template.nome} deleted."
  end

  private # metodo privados que sao utilizados nas funçoes acima para escolher

  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:nome)
  end
end

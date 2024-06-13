class TemplatesController < ApplicationController
  def show
    id = params[:id]
    @template = Template.find(id)
  end
  def index
    @template = Template.all
  end
  def new
    @template = Template.new
  end
  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to templates_path, notice: "#{@template.nome} created."
    else
      flash[:alert] = "template could not be created: " + @template.errors.full_messages.join(", ")
      render 'new'
    end
  end
  def edit
    @template = Template.find params[:id]
  end
end

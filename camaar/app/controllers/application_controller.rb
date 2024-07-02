class ApplicationController < ActionController::Base
  attr_reader :formulario
  attr_reader :formularios

  def initialize_formulario(formulario)
    @formulario = formulario
  end
  def initialize_formularios(formularios)
    @formularios = formularios
  end

end

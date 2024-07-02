class ApplicationController < ActionController::Base
  attr_reader :formulario
  attr_reader :formularios

  attr_reader :materia
  attr_reader :materias

  def initialize_formulario(formulario)
    @formulario = formulario
  end
  def initialize_formularios(formularios)
    @formularios = formularios
  end

  def initialize_materia(materia)
    @materia = materia
  end
  def initialize_materias(materias)
    @materias = materias
  end

end

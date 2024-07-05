##
# Essa é a classe base de todos os controllers da aplicação.
# Todas as controllers herdam dela.
#
# Os métodos são usados para inicializar as variáveis de instância, reduzindo a quantidade de código repetido em cada controller.

class ApplicationController < ActionController::Base
  ##
  # Inicializa a variável de instância @formulario.

  attr_reader :formulario

  ##
  # Inicializa a variável de instância @formularios.

  attr_reader :formularios

  ##
  # Inicializa a variável de instância @materia.

  attr_reader :materia

  ##
  # Inicializa a variável de instância @materias.

  attr_reader :materias


  ##
  # Inicializa a variável de instância @formulario.
  #
  # Parâmetros:
  # formulario: Formulario - O formulário a ser inicializado.

  def initialize_formulario(formulario)
    @formulario = formulario
  end

  ##
  # Inicializa a variável de instância @formularios.
  #
  # Parâmetros:
  # formularios: Formulario[] - Os formulários a serem inicializados.

  def initialize_formularios(formularios)
    @formularios = formularios
  end

  ##
  # Inicializa a variável de instância @materia.
  #
  # Parâmetros:
  # materia: Materia - A matéria a ser inicializada.

  def initialize_materia(materia)
    @materia = materia
  end

  ##
  # Inicializa a variável de instância @materias.
  #
  # Parâmetros:
  # materias: Materia[] - As matérias a serem inicializadas.
  def initialize_materias(materias)
    @materias = materias
  end

end

##
# Responsável por lidar com requisições relacionadas à página inicial.

class HomeController < ApplicationController

  ##
  # Esta ação do controlador é responsável por fornecer dados à view.
  #
  # Definida com alguns dados fictícios.
  #

  def index
    @materia = [
      { codigo: "MAT-101", nome: "Introduction to Programming" },
      { codigo: "MAT-202", nome: "Calculus I" },
      { codigo: "MAT-303", nome: "Linear Algebra" }
    ]
  end
end

class Formulario < ApplicationRecord
  validates :nome, presence: true


  belongs_to :turma
  belongs_to :template
  has_many :respostas
  has_many :questaos
end

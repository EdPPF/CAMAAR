class Template < ApplicationRecord
  has_many :formularios
  has_many :questaos
  validates :nome , presence: true
end

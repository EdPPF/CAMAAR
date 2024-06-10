require 'rails_helper'
=begin
Recomendado colocar na model template pra ficar mais consistente
validates :nome , presence: true
=end
RSpec.describe Template, type: :model do
  it " é valido" do
    template = build(:template)
    expect(template).to be_valid
  end
  it "não é valido, pois nao" do
    template = build(:template, nome: nil)
    expect(template).to_not be_valid
  end
end

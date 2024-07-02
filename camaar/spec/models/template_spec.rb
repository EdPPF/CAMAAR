require 'rails_helper'

RSpec.describe Template, type: :model do
  let(:template) { create(:template) }

  context "validações" do
    it "é válido com atributos válidos" do
      expect(template).to be_valid
    end
    it "não é válido sem um nome" do
      template.nome = nil
      expect(template).to_not be_valid
    end
  end
  context "associações" do
    it "tem muitos formulários" do
      expect(Template.reflect_on_association(:formularios).macro).to eq(:has_many)
    end
    it "tem muitas questões" do
      expect(Template.reflect_on_association(:questaos).macro).to eq(:has_many)
    end
  end
end

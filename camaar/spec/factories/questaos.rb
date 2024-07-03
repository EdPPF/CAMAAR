FactoryBot.define do
  factory :questao do
    texto { "Texto da questão." }
    template { association :template}
  end
end

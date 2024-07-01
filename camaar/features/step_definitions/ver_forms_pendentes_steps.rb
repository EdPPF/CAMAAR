When(/^estou matriculado em ao menos uma turma$/) do
  @user = FactoryBot.create(:user)
  @turma = FactoryBot.create(:turma)
  FactoryBot.create(:matricula, user: @user, turma: @turma)
end

When(/^devo ver os formulários não respondidos de minhas turmas na lista$/) do
  visit formulario_path
  expect(page).to have_content('Formulário não respondido')
end

When(/^todos os formulários de minhas turmas já foram respondidos$/) do

end

When(/^devo ver uma mensagem informando que não há formulários pendentes$/) do
  pending
end

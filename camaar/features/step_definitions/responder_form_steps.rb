When(/^que estou matriculado em ao menos uma turma$/) do
  @user = FactoryBot.create(:user)
  @turma = FactoryBot.create(:turma)
  FactoryBot.create(:matricula, user: @user, turma: @turma)
end

When(/^existe um formulário de avaliação para alguma turma$/) do
  @formulario = FactoryBot.create(:formulario, turma: @turma)
  @questao = FactoryBot.create(:questao, formulario: @formulario)
  FactoryBot.create(:resposta, questao: @questao)
end

When(/^eu preencher o formulário de avaliação de uma turma$/) do
  visit "/formularios/responder/#{@formulario.id}"

  @formulario.questaos.each do |questao|
    fill_in "resposta_value_#{questao.id}", with: 'Minha resposta'
  end
end

When(/^submeter o formulário de avaliação preenchido$/) do
  click_button 'Submit'
end

When(/^devo ver a mensagem "([^"]*)"$/) do |arg|
  expect(page).to have_content(arg)
end

When(/^que estou na página de formulários$/) do
  visit "/formularios"
end

When(/^não estou matriculado em nenhuma turma$/) do
  @user = FactoryBot.create(:user)
end

When(/^eu visualizar a lista de formulários$/) do
  visit "/formularios"
end

When(/^devo ver uma mensagem informando que não estou matriculado em nenhuma turma$/) do
  expect(page).to have_content('Você não está logado.')
end

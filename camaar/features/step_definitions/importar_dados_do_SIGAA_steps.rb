# features/step_definitions/import_steps.rb

Given(/^que estou na tela de configuração$/) do
  visit new_formulario_path
end

When(/^eu clicar no botão "Importar Matéria e Turma"$/) do
  attach_file('file', Rails.root.join('spec/support/class_members.json'))
  click_button 'Importar Matéria e Turma'
end

Then(/^o sistema deve importar os dados de turmas, matérias e participantes do SIGAA$/) do
  expect(page).to have_content("Dados importados com sucesso!")
end

Then(/^o sistema deve exibir uma mensagem de sucesso$/) do
  expect(page).to have_content("Dados importados com sucesso!")
end

When(/^o sistema não conseguir importar os dados$/) do
  attach_file('file', Rails.root.join('spec/support/invalid.json'))
  click_button 'Importar Matéria e Turma'
end

Then(/^o sistema deve exibir uma mensagem de erro$/) do
  expect(page).to have_content("Formato de dados JSON inválido.")
end

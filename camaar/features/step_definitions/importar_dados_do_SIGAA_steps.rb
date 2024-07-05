# features/step_definitions/import_steps.rb

Given(/^que estou na tela de configuração$/) do
  visit new_formulario_path
end

When(/^eu clicar no botão "Importar Matéria e Turma"$/) do
  within('form[action="' + import_materia_and_turma_index_path + '"]') do
    attach_file('file', Rails.root.join('spec/support/classes.json'))
    click_button 'Importar Matéria e Turma'
  end
end

Then(/^o sistema deve exibir uma mensagem de sucesso$/) do
  expect(page).to have_content("Dados importados com sucesso!")
end

When(/^o sistema não conseguir importar os dados$/) do
  within('form[action="' + import_materia_and_turma_index_path + '"]') do
    attach_file('file', Rails.root.join('spec/support/invalid.json'))
    click_button 'Importar Matéria e Turma'
  end
end

Then(/^o sistema deve exibir uma mensagem de erro$/) do
  expect(page).to have_content("Formato de dados JSON inválido.")
end

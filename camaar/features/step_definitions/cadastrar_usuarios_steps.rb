# features/step_definitions/cadastrar_usuarios_steps.rb

Dado(/^que eu estou na página de configuração$/) do
  visit new_formulario_path
end

Dado(/^recebo dado válido$/) do
  @file_path = Rails.root.join('spec/support/class_members.json')
end

Dado(/^recebo dado inválido$/) do
  @file_path = Rails.root.join('spec/support/invalid.json')
end

Quando(/^eu clico no botão "Importar Usuários"$/) do
  within('form[action="' + create_path + '"]') do
    attach_file('file', @file_path)
    click_button 'Importar Usuários'
  end
end

Então(/^eu devo ver uma mensagem de confirmação de cadastro$/) do
  expect(page).to have_content("Dados de usuários importados com sucesso!")
end

Então(/^eu devo ver uma mensagem de erro informando que os usuários não estão cadastrados$/) do
  expect(page).to have_content("Formato de dados JSON inválido.")
end

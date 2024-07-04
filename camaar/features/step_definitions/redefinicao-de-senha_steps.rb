Given('que estou na página de login') do
  visit new_user_session_path
end

When('eu seguir {string}') do |link|
  click_link link
end

When('eu preencher {string} com {string}') do |field, value|
  fill_in field, with: value
end

When('eu pressionar {string}') do |button|
  click_button button
end

Then('eu devo ver {string}') do |message|
  expect(page).to have_content(message)
end

Given('que existe um usuário com o email {string}') do |email|
  @user = FactoryBot.create(:user)
end

Given('o usuário solicitou uma redefinição de senha') do
  @user.send_reset_password_instructions
end

When('o usuário abrir o e-mail de redefinição de senha') do
  open_email(@user.email)
end

When('o usuário seguir o link de redefinição de senha') do
  visit_in_email('Alterar minha senha')
end

When('o usuário preencher {string} com {string}') do |field, value|
  fill_in field, with: value
end

When('o usuário pressionar {string}') do |button|
  click_button button
end

Then('o usuário deve ver {string}') do |message|
  expect(page).to have_content(message)
end

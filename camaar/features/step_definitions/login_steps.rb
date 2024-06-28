When(/^que estou na página de login$/) do
  visit new_user_session_path
end

When(/^eu insiro um e\-mail e senha válidos$/) do

  @user = User.create(nome: "User", email: "user@example.com",
         curso: "CIÊNCIA DA COMPUTAÇÃO/CIC",
         matricula: "190085006", formacao: "graduando", ocupacao: "dicente",
         password: "123456",role: :user,
         password_confirmation: "123456", reset_password_token: nil,
         reset_password_sent_at: nil, remember_created_at: nil)

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
end

When(/^eu clico no botão de login$/) do
  click_button 'Log in'
end

When(/^eu devo ser redirecionado para a página inicial$/) do
  expect(page).to have_current_path(root_path)
end

When(/^eu insiro um e\-mail, matrícula ou senha inválidos$/) do
  @user = User.create(nome: "User", email: "user@example.com",
                      curso: "CIÊNCIA DA COMPUTAÇÃO/CIC",
                      matricula: "190085006", formacao: "graduando", ocupacao: "dicente",
                      password: "123456",role: :user,
                      password_confirmation: "123456", reset_password_token: nil,
                      reset_password_sent_at: nil, remember_created_at: nil)
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'wrongpassword'
end

When(/^eu devo ver uma mensagem de erro$/) do
  expect(page).to have_content('Invalid Email or password.')
end
require 'capybara/email/rspec'

Given(/^que eu estou no meu e\-mail de usuário$/) do
  @user = FactoryBot.create(:user)
end

When(/^eu recebo o e\-mail de troca de senha corretamente$/) do
  @user.send_reset_password_instructions
end

When(/^eu clico em trocar senha$/) do
  #open_email(@user.email)
  current_email.click_link 'Change my password'
end

When(/^devo ser redirecionado a uma página de troca de senha$/) do
  expect(page).to have_current_path(edit_user_password_path(reset_password_token: @user.reload.reset_password_token))
end

When(/^devo poder trocar a minha senha atual por uma nova$/) do
  pending
end

When(/^que eu estou em um e\-mail qualquer$/) do
  #fill_in 'New password', with: 'newpassword'
  #fill_in 'Confirm new password', with: 'newpassword'
  click_button 'Change my password'
  #expect(page).to have_content('Your password has been changed successfully. You are now signed in.')
end

When(/^não tenho acessoa ao email de troca de senha$/) do
  @user = FactoryBot.create(:user)
end

When(/^eu tentar trocar minha senha atual$/) do
  visit edit_user_password_path(reset_password_token: 'invalidtoken')
end

When(/^deve ser exibida uma mensagem de que não é possivel trocar minha senha$/) do
  expect(page).to have_content('Reset password token is invalid')
end

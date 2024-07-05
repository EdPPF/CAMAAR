# language: pt
Funcionalidade: Redefinição de Senha
  #Happy Path
  Cenário: Usuário solicita uma redefinição de senha 
    Dado que estou na página de login
    Quando eu seguir Forgot your password?
    E eu preencher "Email" com "usuario@example.com"
    E eu pressionar "Send me reset password instructions"
    Então eu devo ver "Você receberá um e-mail com instruções sobre como redefinir sua senha em alguns minutos."
  #Happy Path
  Cenário: Usuário redefine a senha com sucesso 
    Dado que existe um usuário com o email "usuario@example.com"
    E o usuário solicitou uma redefinição de senha
    Quando o usuário abrir o e-mail de redefinição de senha
    E o usuário seguir o link de redefinição de senha
    E o usuário preencher "Nova senha" com "novasenha"
    E o usuário preencher "Confirmar nova senha" com "novasenha"
    E o usuário pressionar "Alterar minha senha"
    Então o usuário deve ver "Sua senha foi alterada com sucesso. Você está agora conectado."
  #sad path
  Cenário: Usuário solicita uma redefinição de senha com um email inválido (caminho triste)
    Dado que estou na página de login
    Quando eu seguir "Esqueceu sua senha?"
    E eu preencher "Email" com "email_invalido@example.com"
    E eu pressionar "Enviar instruções para redefinir a senha"
    Então eu devo ver "Email não encontrado."
  
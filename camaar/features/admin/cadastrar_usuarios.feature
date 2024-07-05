# language: pt

Funcionalidade: Cadastrar Usuários no Sistema
    Eu como Administrador
    Quero cadastrar participantes de turmas do SIGAA ao importar dados de usuários novos para o sistema
    Para que eles possam acessar o sistema CAMAAR
    # Lembrando que a importação de dados foi feita em importar_dados_do_SIGAA.feature

    # Happy Path
    Cenário: Cadastrar Novos Usuários
    # Esse cenário deve ser mais complexo? Devem ter mais passos para confirmação de quais usuários serão cadastrados?
    # Ou o admin simplesmente cadastra todos os novos usuários mesmo?
        Dado que eu estou na página de configuração 
        E recebo dado válido
        Quando eu clico no botão "Importar Usuários"
        Então eu devo ver uma mensagem de confirmação de cadastro

    # Sad Path
    Cenário: Erro no cadastro
        Dado que eu estou na página de configuração
        E recebo dado inválido
        Quando eu clico no botão "Importar Usuários"
        Então eu devo ver uma mensagem de erro informando que os usuários não estão cadastrados

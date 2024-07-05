# language: pt

Funcionalidade: Importar Dados do SIGAA
    Eu como Administrador
    Quero importar dados de turmas, matérias e participantes do SIGAA (caso não existam na base de dados atual)
    Para que possa alimentar a base de dados do sistema

    # Happy Path
    Cenário: Importar Dados do SIGAA
        Dado que estou na tela de configuração 
        Quando eu clicar no botão "Importar Matéria e Turma"
        Então o sistema deve exibir uma mensagem de sucesso

    # Sad Path
    Cenário: Erro ao Importar Dados
        Dado que estou na tela de configuração
        Quando eu clicar no botão "Importar Matéria e Turma"
        E o sistema não conseguir importar os dados
        Então o sistema deve exibir uma mensagem de erro


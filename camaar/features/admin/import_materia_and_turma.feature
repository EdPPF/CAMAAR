# language: pt
Funcionalidade: importar materia e turma

  # Happy Path
  Cenário: Importando um dado válido em JSON
    Dado que eu tenho um JSON válido
    Quando fazer uma requisição Post em /import_materia_and_turma
    Então devo ver "data imported sucessfully"
    E Materia deve ser criado
    E Turma deve ser criado
  # Sad Path
  Cenário: Importando dado inválidos em json
    Dado que eu tenho json invalido
    Quando fazer uma requisição Post em "/import_materia_and_turma"
    Então devo ver "Invalid JSON data format."

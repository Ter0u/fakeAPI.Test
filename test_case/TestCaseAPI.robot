*** Settings ***
Documentation                            Documentação API:  https://fakerestapi.azurewebsites.net/api/v1/Books
Resource                                 ../resources/ResourcesAPI.robot
Resource                                 ../steps/StepsAPI.robot
Suite Setup                              Conectar a API

# robot -d ./reports  test_case/TestCaseAPI.robot 

Test Setup                                Conectar a API

*** Test Cases ***
CT1:Buscar Listagem de todos os livros (GET em todos os livros)
    Requisita todos os livros
    Confere o status code    200
    Confere o reason         OK
    Confere se retorna "200" livros

CT2:Buscar um livro específico (GET em livro específico)
    Requisita o livro "15"
    Confere o status code    200
    Confere o reason         OK
    Confere se retorna todos os dados do livro específico

CT3:Cadastrar um livro novo (POST)
    Cadastra o novo livro
    Requisita o novo livro cadastrado "16"
    Confere o status code    200
    Confere o reason         OK
    Confere se retorna todos os dados do novo livro
    
CT4:Alterar um livro (PUT)
   Altera o livro
   Requisita o livro alterado "42"
   Confere o status code    200
   Confere o reason         OK
   Confere se retorna todos os dados do livro alterado

CT5:Deletar um livro (DELETE)
   Requisita o novo livro cadastrado "16"
   Deleta o livro "16"
   Confere o status code    200
   Confere o reason         OK
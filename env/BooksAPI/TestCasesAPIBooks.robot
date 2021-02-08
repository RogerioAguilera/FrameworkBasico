*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Resource        ResourceAPI.robot                                                                                                                                                                                                                                                                                                                                                                                                                    
Suite Setup     Conectar a minha API

*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code   200
    Conferir o reason        OK
    Conferir se retorna uma lista com "200" livros

Buscar um livro específico(GET em um livro específico)
    Requisitar o livro "15"





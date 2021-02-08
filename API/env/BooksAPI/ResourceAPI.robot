*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Library         RequestsLibrary
Library         Collections


*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/
&{BOOK_15}      ID =15
...             Title=Book 15
...             PageCount=1500

*** Keywords ***
## Setups e Teardowns
Conectar a minha API
    Create Session      fakeAPI     ${URL_API}

### Ações
Requisitar todos os livros
    ${RESPOSTA}      Get Request     fakeAPI     Books
    Log              ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}      Get Request     fakeAPI     Books/${ID_LIVRO}
    Log              ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Cadastrar um novo livro
    ${HEADERS}       Create Dictionary      content-type-application
    ${RESPOSTA}      Post Request  fakeAPI  Books
    ...                           data=                     
    ...                           headers=${HEADERS}
### Conferências
Conferir o status code
    [Arguments]                  ${STATUSCODE_DESEJADO}
    Should Be Equal as Strings   ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]                   ${REASON_DESEJADO}
    Should Be Equal as Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros

Length Should Be        ${RESPOSTA.json()}     ${QTDE_LIVROS}


Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item   ${RESPOSTA.json()}   ID             ${BOOK_15.ID}
    Dictionary Should Contain Item   ${RESPOSTA.json()}   Title          ${BOOK_15.Title}
    Dictionary Should Contain Item   ${RESPOSTA.json()}   PageCount      ${BOOK_15.PageCount}

    Should Not Be Empty      ${RESPOSTA.json()["Description"]}
    Should Not Be Empty      ${RESPOSTA.json()["Excerpt"]}
    Should Not Be Empty      ${RESPOSTA.json()["PublishDate"]}




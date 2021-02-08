*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${BROWSER}      chrome  
${URL}          http://automationpractice.com


*** Keywords ***
## Setup e Teardon
Abrir navegador
    Open Browser   about:blank  ${BROWSER}

Fechar navegador
    Close Browser


### Passo a passo
Acessar a página home do site
    Go To    http://automationpractice.com 
    Title Should Be      My Store


Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text     name=search_query    ${PRODUTO}

Clicar no botão pesquisar
    Click Element   name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait until Element Is Visible   css=#center_column
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/7/7-large_default.jpg']
    Page Should Contain Link        xpath=//*[@id="center_column"]//*[@id="product_reference"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible   //*[@id="center_column"]/p[@class='alert alert-warning']
    Element Text Should Be          //*[@id="center_column"]/p[@class='alert alert-warning']

*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    RequestsLibrary
Library    ../resources/libs/elements_base.py

Resource       ../resources/env.resource


*** Variables ***
${FIELD_SEARCH_GOOGLE}       css=[title=Pesquisar]
${LINK_AMAZON}               xpath://h3[text()="Amazon.com.br | Tudo pra você, de A a Z."]/..//h3[@class="LC20lb MBeuO DKV0Md"]
${FIELD_SEARCH_AMAZON}       css=input[placeholder="Pesquisa Amazon.com.br"]
${BTN_SEARCH_AMAZON}         css=#nav-search-submit-button 

*** Keywords ***

Dado que acesso o Google pesquisando por Amazon Brasil
    ${input_text}    Create Dictionary
    ...              amazon_brasil=Amazon Brasil
    
    Open Browser         url=${URL_GOOGLE}         browser=${BROWSER_CHROME}
    Maximize Browser Window
    Input Text         ${FIELD_SEARCH_GOOGLE}      ${input_text}[amazon_brasil] 
    Press Keys         ${FIELD_SEARCH_GOOGLE}      ENTER
    Clicar no primeiro elemento do site Amazon Brasil        ${LINK_AMAZON}

Quando pesquiso o termo Iphone pelo site da Amazon Brasil
    ${input_text}    Create Dictionary
    ...              iphone_apple=Iphone Apple
    
    Input Text         ${FIELD_SEARCH_AMAZON}       ${input_text}[iphone_apple]
    Click Button       ${BTN_SEARCH_AMAZON} 

Fechar navegador
    Close Browser
*** Settings ***
Documentation        Acessar o Google e pesquisar celular Iphone pela Amazon Brasil

Library           SeleniumLibrary
Resource          ../pages/base.resource
Resource          ../pages/iphone_search.resource
Test Setup        Dado que acesso o Google pesquisando por Amazon Brasil
Test Teardown     Fechar navegador  

*** Test Cases ***

Realizar busca de Iphone pela Amazon Brasil e confirmar que 80% da resposta seja itens do tipo buscado
    [Tags]    busca_iphone
    Quando pesquiso o termo Iphone pelo site da Amazon Brasil
    E confiro o total de itens encontrados 
    Então valido que 80% seja itens do tipo Iphone

Realizar busca de Iphone e confirmar que o item de maior valor é menor ou igual a US3000
    [Tags]    maior_valor
    Quando pesquiso o termo Iphone pelo site da Amazon Brasil
    E confiro o item com maior valor
    Então confirmo que o valor convertido em dólar é menor ou igual a US$3000


Itens que não sejam do tipo Iphone deve ter um preço menor    
    [Tags]    valor_menor
    Quando pesquiso o termo Iphone pelo site da Amazon Brasil
    E vejo produtos que não sejam do tipo Iphone
    Então valido que esses produtos tem o valor menor que um Iphone
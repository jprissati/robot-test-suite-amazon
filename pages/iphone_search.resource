*** Settings ***
Resource    ../pages/base.resource

*** Variables ***

${DROPDOWN_RANK}        css=span[class="a-dropdown-container"]
${BIGGER_SMALLER}       css=a[id="s-result-sort-select_2"]
${SMALLER_BIGGER}       css=a[id="s-result-sort-select_1"]
${IPHONE_RETURN}        xpath=//span[contains(text(), "resultados para")]
${IPHONE_TERM}          css=span[class="a-color-state a-text-bold"]
${TOTAL_RESULT}         css=div[class="a-section a-spacing-small puis-padding-left-small puis-padding-right-small"]
${TOTAL_IPHONE}         xpath=//h2/a/span[contains(text(), 'iPhone')] 
${HIGHEST_VALUE}        xpath=//span[@class="a-price-whole"][contains(text(), "14.006")]
${SYMBOLS}              USD         
${ITEM_NAME_SMALLER}    xpath=//span[@class="a-size-base-plus a-color-base a-text-normal"][contains(text(), "Smartphone Xiaomi Redmi 9A Tela 6.53 32GB 13MP 4G Peacock Green CX298VRD")]
${ITEM_VALUE_SMALLER}   xpath=//span[@class='a-price']/span[@class='a-offscreen'][contains(text(),'614,99')]

*** Keywords ***

E confiro o total de itens encontrados    
    ${elements_variable}=    Set Variable        ${IPHONE_RETURN} 
    Wait Until Page Contains Element             ${elements_variable}
    ${number_iphone}=        Get Text            ${elements_variable}
    ${term_iphone}=          Get Text            ${IPHONE_TERM}

    Log To Console           "Resultado: ${number_iphone} ${term_iphone}

Então valido que 80% seja itens do tipo Iphone
    ${total_iphone_elements}=        Get WebElements        ${TOTAL_IPHONE} 
    ${total_result_elements}=        Get WebElements        ${TOTAL_RESULT} 
    
    ${total_iphone}=                 Get Length             ${total_iphone_elements}
    ${total_result}=                 Get Length             ${total_result_elements}

    ${result1}=                      Evaluate               ${total_iphone} * 100
    ${result2}=                      Evaluate               ${result1} / ${total_result}
    ${formatted_percentage}=         Evaluate               round(${result2}, 2)

    Log To Console                   "O percentual é: ${formatted_percentage}%"
    
    ${greater_equal}=                Evaluate               ${formatted_percentage} >= 80
    Should Be True                   ${greater_equal}

E confiro o item com maior valor
    Click Element                    ${DROPDOWN_RANK}
    Selecionar o item de maior para menor valor        ${BIGGER_SMALLER}
    Wait Until Page Contains Element                   ${HIGHEST_VALUE}
    ${highest_value_iphone}=        Get Text           ${HIGHEST_VALUE}

    Log To Console                  O valor encontrado do Iphone mais caro é:${highest_value_iphone}

Então confirmo que o valor convertido em dólar é menor ou igual a US$3000
    ${parameters_endpoint}    Create Dictionary
    ...              base=BRL
    ...              symbols=USD
             
    ${highest_value_iphone}=        Get Text                ${HIGHEST_VALUE} 
    ${dollar_converter}=            Set Variable            ${highest_value_iphone.replace('.', '').replace(',', '.')}
    
    Create Session                  Exchangeratesapi        ${BASE_URI}    
    ${resp}=    GET On Session      Exchangeratesapi        url=${parameters_endpoint}[base]?apikey=${ACCESS_KEY}&symbols=${parameters_endpoint}[symbols] / expected_status=200
    
    ${json_data}=                   Evaluate                json.loads('''${resp.content}''')        json
    ${exchange_rate_usd}=           Get From Dictionary     ${json_data}                             rates        default=None

    
    ${exchange_tax}                 Set Variable            ${resp.json()['rates']['${SYMBOLS}']}
    ${dollar_conversation}          Evaluate                ${dollar_converter} * ${exchange_tax}
    ${converted_value}=             Evaluate                round(${dollar_conversation}, 2)

    Log To Console   O Iphone de maior valor é R$${dollar_converter}, que convertido para dólar, fica: US$${converted_value}

    ${less_equal}                   Evaluate                ${converted_value} <= 3000  
    Should Be True                  ${less_equal}

E vejo produtos que não sejam do tipo Iphone
    Click Element        ${DROPDOWN_RANK} 
    Click Element        ${SMALLER_BIGGER} 

Então valido que esses produtos tem o valor menor que um Iphone
    Wait Until Page Contains Element           ${ITEM_VALUE_SMALLER} 
    ${item_name}=              Get Text        ${ITEM_NAME_SMALLER}
    ${item_value}=             Get Text        ${ITEM_VALUE_SMALLER} 
    ${item_value_formatted}=   Set Variable    ${item_value[:-2]},${item_value[-2:]}

    Log To Console    "O valor do ${item_name}, produto mais barato da lista, é: ${item_value_formatted}



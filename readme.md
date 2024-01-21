# Teste de Busca de iPhones na Amazon Brasil

## Visão Geral

Este projeto realiza testes automatizados de busca por iPhones na Amazon Brasil usando o framework Robot Framework e Selenium.

## Pré-requisitos

- Python
- Robot Framework
- Bibliotecas necessárias (SeleniumLibrary, Collections, RequestsLibrary)

## Configuração do Ambiente

1. Instale o Python: [https://www.python.org/](https://www.python.org/)
2. Instale o Robot Framework: [https://robotframework.org/](https://robotframework.org/)
3. Instale as bibliotecas necessárias:
   ```bash
   pip install robotframework 
   robotframework-seleniumlibrary 
   robotframework-collections 
   robotframework-requests

## Execução de cenários
Toda suíte: robot -d ./logs tests/iphone_search.robot
Cenário Busca por iPhones na Amazon Brasil e Validar Resultados (80% iPhones): robot -d ./logs -i busca_iphone tests/iphone_search.robot
Cenário Confirmar que o Item de Maior Valor é Menor ou Igual a US$3000: robot -d ./logs -i maior_valor tests/iphone_search.robot
Cenário Validar que Produtos que Não São iPhones Têm um Preço Menor: robot -d ./logs -i valor_menor tests/iphone_search.robot


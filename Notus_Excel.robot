*** Settings ***
Library  ExcelLibrary

*** Variables ***


*** Keywords ***

# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF notus_excel.robot
# robot -d results notus_excel.robot

*** Test Cases ***
Read File Excel
    open excel document  /Users/notuspham/PycharmProjects/NotusProject/Resources/test.xlsx  doc_id=doc1
    ${t1} =  read excel cell  1  2
    log to console  ${t1}
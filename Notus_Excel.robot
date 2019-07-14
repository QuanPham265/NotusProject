*** Settings ***
Library  ExcelLibrary

*** Variables ***


*** Keywords ***

# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF notus_excel.robot
# robot -d results notus_excel.robot

*** Test Cases ***
Read File Excel
    open excel document  /Users/notuspham/PycharmProjects/NotusProject/Resources/Excel_File/insta_profile_hoangmy.xlsx  doc_id=doc1
    ${t1} =  read excel cell  row_num=1  col_num=1  sheet_name=user_like
    log to console  ${t1}
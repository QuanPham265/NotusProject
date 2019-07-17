*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/String.py
Resource  ./PO/PO_Home.robot
Resource  ./PO/PO_AddCard.robot
Resource  ./PO/PO_Card_Account_Management.robot
Resource  ./PO/PO_SelectBank.robot

*** Variables ***
&{dict_All_BankCode}    VCB=970436          VTB=970415          BIDV=970418         TCB=970407          ACB=970416
...  MB=970422          VPB=970432          AGB=970405          SHB=970443          STB=970403          HDB=970437
...  TPB=970423         EXB=970431          VIBB=970441         ABB=970425          MTB=970426          NAB=970428
...  VAB=970427         BAB=970409          OCB=970414          SEAB=970440         NCB=970419          PVCB=970412

*** Keywords ***
Generate Random Bank Card Number
    [Arguments]  ${bank_code_chart}
    ${suffix_bank_number} =  generate random string  10  [NUMBERS]
    ${prefix_bank_number} =  set variable  &{dict_All_BankCode}[${bank_code_chart}]
    ${card_no} =  catenate  SEPARATOR=  ${prefix_bank_number}   ${suffix_bank_number}
    log  ${card_no}
    [Return]  ${card_no}

Access Screen Manage Link Account
    PO_Home.Select Link Acccount

Access Screen Manage Bank Account

Access Screen Manage Bank Card
    PO_Home.Select Link Acccount
    PO_Card_Account_Management.Select Overview Bank Card

Verify Limit Bank Card Allow Adding For eWallet Without Complete KYC
    PO_Card_Account_Management.Add Bank Card
    PO_SelectBank.Verify Screen Select Bank Loaded
    ${nb_display_domestic_card} =  PO_SelectBank.Get Number Displayed Domestic Card
    run keyword if  ${nb_display_domestic_card} > 10  fail

Select Add Bank Card Sacombank
    PO_Card_Account_Management.Add Bank Card
    PO_SelectBank.Verify Screen Select Bank Loaded
    PO_SelectBank.Choose Add Card Sacombank - Display Limit Bank

Verify Enable Editing Fields Identity Card And eWallet's Username
    #true: can edit, false: block edit
    [Arguments]  ${exp_state_idcard}  ${exp_state_username}
    ${app_state_username} =  PO_AddCard.Get Bank Card Holder Name - State Edit
    ${app_state_idcard} =    PO_AddCard.Get Bank Customer Identity Card - State Edit
    should be equal as strings  ${exp_state_idcard}    ${app_state_idcard}
    should be equal as strings  ${exp_state_username}  ${app_state_username}

Verify Autofill Fields Identity Card And eWallet's Username
    [Arguments]  ${fullname}  ${idcard}
    ${app_bank_card_holdername} =     PO_AddCard.Get Bank Card Holder Name - Text
    ${app_customer_identity_card} =   PO_AddCard.Get Bank Customer Identity Card - Text
    should be equal as strings  ${app_bank_card_holdername}    ${fullname}
    should be equal as strings  ${app_customer_identity_card}  ${idcard}

Add Bank Card Sacombank Successfully
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_AddCard.Input Bank Card Number  ${card_no_stb}
    PO_AddCard.Click Button Confirm Add Card
    PO_AddCard.Input OTP
    PO_AddCard.Click Button Submit OTP
    ${state_shown_popup} =  PO_AddCard.State OF Shown Error Popup
    run keyword if  ${state_shown_popup}  fail  #IF state_shown_popup=true -> test case fail
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded



Verify Load Identify Card And Name From User Profile


Dev Keyword Bank Card
    PO_AddCard.Verify Screen Select Bank Loaded
    ${nb_display_domestic_card} =  PO_AddCard.Get Number Displayed Domestic Card
    PO_AddCard.Choose Add Card Sacombank - Display Full Bank
    PO_AddCard.Verify Screen Add Card Loaded

    PO_AddCard.Get Bank Card Number - State Enabled Edit
    PO_AddCard.Get Bank Card Number - State Displayed



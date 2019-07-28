*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Library  D:/Gitlab/PayooMobileApp/Libraries/String.py
Resource  ./PO/PO_Home.robot
Resource  ./PO/PO_AddCard.robot
Resource  ./PO/PO_EditCard.robot
Resource  ./PO/PO_LinkBank.robot
Resource  ./PO/PO_Card_Account_Management.robot
Resource  ./PO/PO_SelectBank.robot
Resource  ../Libraries/SqlDatabase.robot

*** Variables ***
&{dict_All_BankCode}    VCB=970436          VTB=970415          BIDV=970418         TCB=970407          ACB=970416
...  MB=970422          VPB=970432          AGB=970405          SHB=970443          STB=970403          HDB=970437
...  TPB=970423         EXB=970431          VIBB=970441         ABB=970425          MTB=970426          NAB=970428
...  VAB=970427         BAB=970409          OCB=970414          SEAB=970440         NCB=970419          PVCB=970412

*** Keywords ***
Test SQL
    SqlDatabase.Connect database
#    SqlDatabase.Get BankAccountID Of UserName Which Latest Added  qtest_kyc_5
#    SqlDatabase.Modify Full Bank Card No    9704035555559999
    SqlDatabase.Update BankAccountReliability For Certain Bank Card/Account  qtest_kyc_5    6645    choduyet
    SqlDatabase.Disconnect database

Generate Random Bank Card Number
    [Arguments]  ${bank_code_chart}
    ${suffix_bank_number} =  generate random string  10  [NUMBERS]
    ${prefix_bank_number} =  set variable  &{dict_All_BankCode}[${bank_code_chart}]
    ${card_no} =  catenate  SEPARATOR=  ${prefix_bank_number}   ${suffix_bank_number}
    log  ${card_no}
    [Return]  ${card_no}

Access Screen Manage Link Account
    PO_Home.Select Link Acccount
    PO_Card_Account_Management.Select Overview Bank Link

Access Screen Manage Bank Account

Access Screen Manage Bank Card
    PO_Home.Select Link Acccount
    PO_Card_Account_Management.Select Overview Bank Card

Verify Limit Bank Card Allow Adding For eWallet Without Complete KYC
    PO_Card_Account_Management.Add Bank Card
    PO_SelectBank.Verify Screen Select Bank Loaded
    ${nb_display_domestic_card} =  PO_SelectBank.Get Number Displayed Domestic Card
    run keyword if  ${nb_display_domestic_card} > 10  fail

Select Add Bank Card Sacombank - Show Only Bank Support KYC
    PO_Card_Account_Management.Add Bank Card
    PO_SelectBank.Verify Screen Select Bank Loaded
    PO_SelectBank.Choose Add Card Sacombank - Display Limit Bank
    PO_AddCard.Verify Screen Add Card Loaded

Select Link Bank Card Sacombank - Show Only Bank Support KYC
    PO_Card_Account_Management.Add Bank Link
    PO_SelectBank.Verify Screen Select Bank Loaded
    PO_SelectBank.Choose Link Bank Sacombank - Display Limit Bank
    PO_LinkBank.Verify Screen Link Bank Loaded

Select Edit Bank Card Sacombank
    PO_Card_Account_Management.Edit Bank Card
    PO_EditCard.Verify Screen Edit Card Loaded

Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card
    #true: can edit, false: block edit
    [Arguments]  ${exp_state_idcard}  ${exp_state_username}
    ${app_state_username} =  PO_AddCard.Get Bank Card Holder Name - State Edit
    ${app_state_idcard} =    PO_AddCard.Get Bank Customer Identity Card - State Edit
    should be equal as strings  ${exp_state_idcard}    ${app_state_idcard}
    should be equal as strings  ${exp_state_username}  ${app_state_username}

Verify Enable Editing Field - Edit Bank Card Sacombank
    #true: can edit, false: block edit
    [Arguments]  ${exp_state_cardno}  ${exp_state_username}
    ${app_state_username} =  PO_EditCard.Get Bank Card Holder Name - State Edit
    ${app_state_cardno} =    PO_EditCard.Get Bank Card Number - State Display
    should be equal as strings  ${exp_state_cardno}    ${app_state_cardno}
    should be equal as strings  ${exp_state_username}  ${app_state_username}

Verify Enable Editing Field - Edit Bank Card ABBank
    #true: can edit, false: block edit
    [Arguments]  ${exp_state_idcard}  ${exp_state_username}  ${exp_state_issue_date}
    ${app_state_username} =      PO_EditCard.Get Bank Card Holder Name - State Edit
    ${app_state_idcard} =        PO_EditCard.Get Bank Customer Identity Card - State Edit
    ${app_state_issue_date} =    PO_EditCard.Get Bank Card Date - State Edit
    should be equal as strings  ${exp_state_idcard}         ${app_state_idcard}
    should be equal as strings  ${exp_state_username}       ${app_state_username}
    should be equal as strings  ${exp_state_issue_date}     ${app_state_issue_date}

Verify Autofill Fields Identity Card And eWallet's Username - Bank Card
    [Arguments]  ${fullname}  ${idcard}
    ${app_bank_card_holdername} =     PO_AddCard.Get Bank Card Holder Name - Text
    ${app_customer_identity_card} =   PO_AddCard.Get Bank Customer Identity Card - Text
    should be equal as strings  ${app_bank_card_holdername}    ${fullname}
    should be equal as strings  ${app_customer_identity_card}  ${idcard}

Verify Enable Editing Fields Identity Card And eWallet's Username - Bank Link
    #true: can edit, false: block edit
    [Arguments]  ${exp_state_idcard}  ${exp_state_username}
    ${app_state_username} =  PO_LinkBank.Get Link Bank Card Holder Name - State Edit
    ${app_state_idcard} =    PO_LinkBank.Get Link Bank Customer Identity Card - State Edit
    should be equal as strings  ${exp_state_idcard}    ${app_state_idcard}
    should be equal as strings  ${exp_state_username}  ${app_state_username}

Verify Autofill Fields Identity Card And eWallet's Username - Bank Link
    [Arguments]  ${fullname}  ${idcard}
    ${app_bank_card_holdername} =     PO_LinkBank.Get Link Bank Card Holder Name - Text
    ${app_customer_identity_card} =   PO_LinkBank.Get Link Bank Customer Identity Card - Text
    should be equal as strings  ${app_bank_card_holdername}    ${fullname}
    should be equal as strings  ${app_customer_identity_card}  ${idcard}

Add Bank Card Sacombank Successfully - Keep Autofill ID Card And Name
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_AddCard.Input Bank Card Number  ${card_no_stb}
    PO_AddCard.Click Button Confirm Add Card
    PO_AddCard.Input OTP
    PO_AddCard.Click Button Submit OTP
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded

Add Bank Card Sacombank Successfully
    [Arguments]  ${card_holder_name}  ${identity_card}
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card
    PO_AddCard.Input OTP
    PO_AddCard.Click Button Submit OTP
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded
    [Return]  ${card_no_stb}

Add Bank Card Sacombank Double Times
    [Arguments]  ${card_holder_name}  ${identity_card}
    Select Add Bank Card Sacombank - Show Only Bank Support KYC
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card
    PO_AddCard.Input OTP
    PO_AddCard.Click Button Submit OTP
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded
    # Add 2nd time
    Select Add Bank Card Sacombank - Show Only Bank Support KYC
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card

Add New Bank Card Sacombank With Error Happen After Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card
    PO_AddCard.Input OTP
    PO_AddCard.Click Button Submit OTP

Add New Bank Card Sacombank With Error Happen Before Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card

Add Exist Bank Card Sacombank With Error Happen After Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}  ${card_no_stb}
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card
    PO_AddCard.Input OTP
    PO_AddCard.Click Button Submit OTP

Add Exist Bank Card Sacombank With Error Happen Before Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}  ${card_no_stb}
    PO_AddCard.Input Bank Card Number           ${card_no_stb}
    PO_AddCard.Input Bank Card Holder Name      ${card_holder_name}
    PO_AddCard.Input Customer Identity Card     ${identity_card}
    PO_AddCard.Click Button Confirm Add Card

# Add Link Card/Account
Add Link Bank Card Sacombank Successfully - Keep Autofill ID Card And Name
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_LinkBank.Input Bank Card Number  ${card_no_stb}
    PO_LinkBank.Click Button Confirm Link
    PO_LinkBank.Input OTP
    PO_LinkBank.Click Button Submit OTP
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded

Add Link Bank Card Sacombank Successfully
    [Arguments]  ${card_holder_name}  ${identity_card}
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_LinkBank.Input Bank Card Number           ${card_no_stb}
    PO_LinkBank.Input Bank Card Holder Name      ${card_holder_name}
    PO_LinkBank.Input Customer Identity Card     ${identity_card}
    PO_LinkBank.Click Button Confirm Link
    PO_LinkBank.Input OTP
    PO_LinkBank.Click Button Submit OTP
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded

Add New Link Bank Card Sacombank With Error Happen After Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_LinkBank.Input Bank Card Number           ${card_no_stb}
    PO_LinkBank.Input Bank Card Holder Name      ${card_holder_name}
    PO_LinkBank.Input Customer Identity Card     ${identity_card}
    PO_LinkBank.Click Button Confirm Link
    PO_LinkBank.Input OTP
    PO_LinkBank.Click Button Submit OTP

Add New Link Bank Card Sacombank With Error Happen Before Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}
    ${card_no_stb} =  Generate Random Bank Card Number  STB
    PO_LinkBank.Input Bank Card Number           ${card_no_stb}
    PO_LinkBank.Input Bank Card Holder Name      ${card_holder_name}
    PO_LinkBank.Input Customer Identity Card     ${identity_card}
    PO_LinkBank.Click Button Confirm Link

Add Exist Link Bank Card Sacombank With Error Happen After Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}  ${card_no_stb}
    PO_LinkBank.Input Bank Card Number           ${card_no_stb}
    PO_LinkBank.Input Bank Card Holder Name      ${card_holder_name}
    PO_LinkBank.Input Customer Identity Card     ${identity_card}
    PO_LinkBank.Click Button Confirm Link
    PO_LinkBank.Input OTP
    PO_LinkBank.Click Button Submit OTP

Add Exist Link Bank Card Sacombank With Error Happen Before Input OTP
    [Arguments]  ${card_holder_name}  ${identity_card}  ${card_no_stb}
    PO_LinkBank.Input Bank Card Number           ${card_no_stb}
    PO_LinkBank.Input Bank Card Holder Name      ${card_holder_name}
    PO_LinkBank.Input Customer Identity Card     ${identity_card}
    PO_LinkBank.Click Button Confirm Link

Clean up Link Bank Card Added Before
    PO_Card_Account_Management.Remove Bank Link
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded

Clean up Bank Card Added Before
    PO_Card_Account_Management.Remove Bank Card
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded

Verify Error Notification
    [Arguments]  ${exp_error_content}=temp
    ${state_add_success} =  run keyword and return status  PO_Card_Account_Management.Verify Screen Card/Account Management Loaded
    run keyword if  ${state_add_success}  fail
    ${app_error_notification_title} =    PO_AddCard.Get Error Notification - Title
    ${app_error_notification_content} =  PO_AddCard.Get Error Notification - Content
    should be equal as strings  ${exp_error_content}  ${app_error_notification_content}

Back To Screen Card Account Management From Edit Card
    PO_EditCard.Click Button Back
    PO_Card_Account_Management.Verify Screen Card/Account Management Loaded

Change Value BankAccountReliability Of Bank Card By Script SQL
    [Arguments]  ${username}  ${card_no}  ${type_bankcardreliability}
    SqlDatabase.Connect database
    ${bankaccountid} =  SqlDatabase.Get BankAccountID Of UserName Which Latest Added    ${username}  ${card_no}
    SqlDatabase.Update BankAccountReliability For Certain Bank Card/Account             ${username}  ${bankaccountid}  ${type_bankcardreliability}
    SqlDatabase.Disconnect database

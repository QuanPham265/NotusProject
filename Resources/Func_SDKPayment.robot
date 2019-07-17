*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Library  String
Resource  ./PO/PO_SDKPayment_init.robot
Resource  ./PO/PO_SDKPayment_CardInfo.robot
Resource  ./PO/PO_SDKPayment_Confirmation.robot
Resource  ./PO/PO_SDKPayment_External.robot
Resource  ./common.robot


*** Variables ***
&{cases_filter_paymentmethod}  1=DomesticCard,InternationalCard,eWallet,Pay@store,Installment  2=Installment,DomesticCard
...  3=DomesticCard,InternationalCard,eWallet  4=eWallet,DomesticCard,Installment

&{dict_All_BankCode}    VCB=970436          VTB=970415          BIDV=970418         TCB=970407          ACB=970416
...  MB=970422          VPB=970432          AGB=970405          SHB=970443          STB=970403          HDB=970437
...  TPB=970423         EXB=970431          VIBB=970441         ABB=970425          MTB=970426          NAB=970428
...  VAB=970427         BAB=970409          OCB=970414          SEAB=970440         NCB=970419          PVCB=970412


${count_payments_method}
*** Keywords ***
Create Order For SDK Payment
    [Arguments]  ${amount}  ${email}  ${phone}  ${bank_code}=Skip  ${user_id}=Skip  ${aut_token}=Skip
    PO_SDKPayment_init.Wait App SDK Payment Loaded
    PO_SDKPayment_init.Clean Up All Text Box
    PO_SDKPayment_init.Fill Init Amount         ${amount}
    PO_SDKPayment_init.Fill Init Email          ${email}
    PO_SDKPayment_init.Fill Init Phone          ${phone}

    run keyword if  '${bank_code}' != 'Skip'     PO_SDKPayment_init.Fill Init Bank Code      ${bank_code}
    run keyword if  '${user_id}' != 'Skip'       PO_SDKPayment_init.Fill Init User_ID        ${user_id}
    run keyword if  '${aut_token}' != 'Skip'     PO_SDKPayment_init.Fill Init Aut Token      ${aut_token}

Select Payment Method
    [Arguments]  ${str_payment_method}
    @{list_payment_method} =  split string  ${str_payment_method}  ,
    log list  ${list_payment_method}
#    ${tmp} =  get length  ${list_payment_method}
#    set test variable  ${count_payments_method}  ${tmp}
#    ${count_payments_method} =  convert to string  ${count_payments_method}
    : FOR    ${payment_method}    IN   @{list_payment_method}
    \   PO_SDKPayment_init.Init Select Payment Method  ${payment_method}

Unselect Payment Method
    [Arguments]  ${str_payment_method}
    @{list_payment_method} =  split string  ${str_payment_method}  ,
    log list  ${list_payment_method}
    : FOR    ${payment_method}    IN   @{list_payment_method}
    \   PO_SDKPayment_init.Init Select Payment Method  ${payment_method}

Verify Shown Payment Method
    [Arguments]  ${str_payment_method}
    @{list_payment_method} =  split string  ${str_payment_method}  ,
    log list  ${list_payment_method}
    : FOR    ${payment_method}    IN   @{list_payment_method}
    \   PO_SDKPayment_init.Verify Show Payment Method  ${payment_method}

Verify Show On/Off Payment Method
    : FOR    ${index}    IN RANGE    1    5
    \   ${index} =  convert to string  ${index}
    \   ${str_checked_paymentmethod} =  set variable  &{cases_filter_paymentmethod}[${index}]
    \   Func_SDKPayment.Select Payment Method               ${str_checked_paymentmethod}
    \   PO_SDKPayment_init.Click Button Pay
    \   Verify Shown Payment Method         ${str_checked_paymentmethod}
    \   Click Button Back And Close Notification
    \   Func_SDKPayment.Unselect Payment Method             ${str_checked_paymentmethod}

### Domestic Card
Payment By Domestic Card - Input Bank Card Information - STB
    [Arguments]  ${card_holdername}  ${enable_payment_method}=skip
    ${bank_code} =  set variable  STB
    ${prefix_bank_number} =  set variable  &{dict_All_BankCode}[${bank_code}]
    ${card_number} =  catenate  SEPARATOR=  ${prefix_bank_number}   1593652230
    PO_SDKPayment_init.Click Button Pay
    run keyword if  '${enable_payment_method}' == 'DomesticCard'   PO_SDKPayment_init.Screen Payment Method - Select Method  DomesticCard
    PO_SDKPayment_CardInfo.Wait Card Information Loaded
    PO_SDKPayment_CardInfo.Fill Card Number         ${card_number}
    PO_SDKPayment_CardInfo.Fill Card Holder Name    ${card_holdername}
    PO_SDKPayment_CardInfo.Click Button Continue

Payment By Domestic Card - Verify Confirmation Order
    PO_SDKPayment_Confirmation.Wait SDK Payment Page Confirmation Loaded
    PO_SDKPayment_Confirmation.Click Button Continue

Payment By Domestic Card - Input OTP And Verify Result Payment
    PO_SDKPayment_Confirmation.Fill OTP And Complete Payment
    PO_SDKPayment_init.Get Result Payment And Close Notification

Payment By Domestic Card - Return Failure Result
    PO_SDKPayment_init.Click Button Pay
    PO_SDKPayment_init.Get Result Payment And Close Notification  FAILURE

Payment By Domestic Card - Show Warning With Invalid Information
    [Arguments]  ${expect_message}
    ${message} =  PO_SDKPayment_CardInfo.Get Message Of Alert
    should be equal as strings  ${expect_message}  ${message}

External Payment By Domestic Card - STB
    [Arguments]  ${card_no}  ${card_name}  ${phone}  ${email}
    PO_SDKPayment_init.Click Button Pay
#    PO_SDKPayment_init.Choose Domestic Card - Sacombank
    PO_SDKPayment_External.Verify Payment Method Domestic Loaded
    PO_SDKPayment_External.Domestic Card - Fill CardNo         ${card_no}
    PO_SDKPayment_External.Domestic Card - Fill CardName       ${card_name}
    PO_SDKPayment_External.Domestic Card - Fill Phone          ${phone}
    PO_SDKPayment_External.Domestic Card - Fill Email          ${email}
    pause execution
    PO_SDKPayment_External.Click Button Continue
    PO_SDKPayment_External.Fill OTP

### International Card
Payment By International Card - Input Bank Card Information
    [Arguments]  ${card_holdername}  ${card_number}  ${expiry_date}  ${cvc}  ${enable_payment_method}=skip
    PO_SDKPayment_init.Click Button Pay
    run keyword if  '${enable_payment_method}' == 'InternationalCard'   PO_SDKPayment_init.Screen Payment Method - Select Method  InternationalCard
    PO_SDKPayment_CardInfo.Wait Card Information Loaded
    PO_SDKPayment_CardInfo.Fill Card Number                     ${card_number}
    PO_SDKPayment_CardInfo.Fill Card Holder Name                ${card_holdername}
    PO_SDKPayment_CardInfo.Fill ExpiryDate International        ${expiry_date}
    PO_SDKPayment_CardInfo.Fill CVC                             ${cvc}
    PO_SDKPayment_CardInfo.Click Button Continue

Payment By International Card - Verify Confirmation Order
    PO_SDKPayment_Confirmation.Wait SDK Payment Page Confirmation Loaded
    PO_SDKPayment_Confirmation.Click Button Continue

Payment By International Card - Input OTP And Verify Result Payment
    PO_SDKPayment_init.Get Result Payment And Close Notification

Payment By International Card - Return Failure Result
    PO_SDKPayment_init.Click Button Pay
    PO_SDKPayment_init.Get Result Payment And Close Notification  FAILURE

Payment By International Card - Show Warning With Invalid Information
    [Arguments]  ${expect_message}
    ${message} =  PO_SDKPayment_CardInfo.Get Message Of Alert
    should be equal as strings  ${expect_message}  ${message}

External Payment By International Card
    [Arguments]  ${card_holdername}  ${card_number}  ${expiry_date}  ${cvc}  ${phone}  ${email}
#    PO_SDKPayment_init.Click Button Pay
    PO_SDKPayment_External.Verify Payment Method International Loaded
    PO_SDKPayment_External.International Card - Scroll Down
    PO_SDKPayment_External.International Card - CardNo         ${card_number}
    PO_SDKPayment_External.International Card - CardName       ${card_holdername}
    PO_SDKPayment_External.International Card - Expiry Date    ${expiry_date}
    PO_SDKPayment_External.International Card - CVC            ${cvc}
    PO_SDKPayment_External.International Card - Phone          ${phone}
    PO_SDKPayment_External.International Card - Email          ${email}
    pause execution
    PO_SDKPayment_External.International Card - Click Button Continue
    pause execution
    PO_SDKPayment_External.Click Button Continue
    PO_SDKPayment_External.Fill OTP

### Credit Installment
Payment By Credit Installment - Input Bank Card Information - STB
    [Arguments]  ${card_holdername}  ${card_number}  ${installment_period}  ${expiry_date}  ${cvc}  ${enable_payment_method}=skip
    PO_SDKPayment_init.Click Button Pay
    run keyword if  '${enable_payment_method}' == 'Installment'   PO_SDKPayment_init.Screen Payment Method - Select Method  Installment
    PO_SDKPayment_CardInfo.Wait Card Information Loaded
    PO_SDKPayment_CardInfo.Fill Card Number             ${card_number}
    PO_SDKPayment_CardInfo.Fill Card Holder Name        ${card_holdername}
    PO_SDKPayment_CardInfo.Choose Period Installment    ${installment_period}
    PO_SDKPayment_CardInfo.Fill ExpiryDate              ${expiry_date}
    PO_SDKPayment_CardInfo.Fill CVC                     ${cvc}
    PO_SDKPayment_CardInfo.Click Button Continue

Payment By Credit Installment - Verify Confirmation Order
    PO_SDKPayment_Confirmation.Wait SDK Payment Page Confirmation Loaded
    PO_SDKPayment_Confirmation.Click Button Continue

Payment By Credit Installment - Verify Result Payment
    PO_SDKPayment_init.Get Result Payment And Close Notification

Payment By Credit Installment - Return Failure Result
    PO_SDKPayment_init.Click Button Pay
    PO_SDKPayment_init.Get Result Payment And Close Notification  FAILURE

### eWallet
Payment By eWallet On App Web Browser
    [Arguments]  ${username}  ${password}
    PO_SDKPayment_init.Click Button Pay
    PO_SDKPayment_External.Verify Payment Method eWallet Loaded
    PO_SDKPayment_External.Fill eWallet Username    ${username}
    PO_SDKPayment_External.Fill eWallet Password    ${password}
    PO_SDKPayment_External.Click Button Login
    PO_SDKPayment_External.Click Button PAY

Payment By eWallet - Verify Result Payment Success
    PO_SDKPayment_init.Get Result Payment And Close Notification
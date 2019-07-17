*** Settings ***
Library  Dialogs
Library  Collections
Library  AppiumLibrary
Library  OperatingSystem
Library  Process
Resource  ../Resources/common.robot
Resource  ../Resources/Func_SDKPayment.robot

#Test Setup          common.Begin Testing Android SDK Payment
#Test Teardown       common.End Testing
Documentation  gdgd

*** Variables ***
${amount}           190000
${email}            qctest@gmail.com
${phone}            0986636649
${bank_code}        STB
${expiry_date}      1122
${cvc}              965
${card_holdername}  NGUYEN VAN AZ

${domestic_stb_card}        9704036633256315
${installment_cardnumber}   4111111111111111
${installment_amount}       9000000

${alert_invalid_cardname}       Incorrect name. Full name is composed of at most 50 alphabet characters without any special character, diacritical mark and has at least one space in between.
${alert_invalid_expirydate}     Expiry date is invalid. Please enter again.

# How to run Script
# robot -d C:/results/MobileApp -i qtest tests/SDK_Payment.robot

*** Test Cases ***
Show Correct Payment Method By Config Without Filling Bank Code
    [Tags]  SDK_Internal
    [Documentation]  show_payment_method_without_bank_code
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}
    Func_SDKPayment.Verify Show On/Off Payment Method

SDK Payment Method - eWallet
    [Tags]  SDK_Internal  eWallet
    common.Browser Chrome
    common.Begin Testing Android SDK Payment
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}
    Func_SDKPayment.Select Payment Method  eWallet
    Func_SDKPayment.Payment By eWallet On App Web Browser  quanpham  123456789
    Func_SDKPayment.Payment By eWallet - Verify Result Payment Success

SDK Payment Method - Domestic Card - Input STB And Select Muiltiple Methods
    [Tags]  SDK_Internal  Domestic_Card  STB
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  STB
    Func_SDKPayment.Select Payment Method  eWallet,DomesticCard,Installment
    Func_SDKPayment.Payment By Domestic Card - Input Bank Card Information - STB  ${card_holdername}  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Verify Confirmation Order
    Func_SDKPayment.Payment By Domestic Card - Input OTP And Verify Result Payment

SDK Payment Method - Domestic Card - Input STB
    [Tags]  SDK_Internal  Domestic_Card  STB
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  STB
    Func_SDKPayment.Select Payment Method  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Input Bank Card Information - STB  ${card_holdername}
    Func_SDKPayment.Payment By Domestic Card - Verify Confirmation Order
    Func_SDKPayment.Payment By Domestic Card - Input OTP And Verify Result Payment

SDK Payment Method - Domestic Card
    [Tags]  SDK_Internal  Domestic_Card  STB
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}
    Func_SDKPayment.Select Payment Method  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Input Bank Card Information - STB  ${card_holdername}
    Func_SDKPayment.Payment By Domestic Card - Verify Confirmation Order
    Func_SDKPayment.Payment By Domestic Card - Input OTP And Verify Result Payment

SDK Payment Method - Domestic Card - Muiltiple Methods
    [Tags]  SDK_Internal  Domestic_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}
    Func_SDKPayment.Select Payment Method  eWallet,DomesticCard,Installment
    Func_SDKPayment.Payment By Domestic Card - Input Bank Card Information - STB  ${card_holdername}  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Verify Confirmation Order
    Func_SDKPayment.Payment By Domestic Card - Input OTP And Verify Result Payment

SDK Payment Method - Domestic Card - Invalid BankCode
    [Tags]  SDK_Internal  Domestic_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  ERP
    Func_SDKPayment.Select Payment Method  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Return Failure Result

SDK Payment Method - Domestic Card - Unsupported Bank Code
    [Tags]  SDK_Internal  Domestic_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  VISA
    Func_SDKPayment.Select Payment Method  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Return Failure Result

SDK Payment Method - Domestic Card - Invalid Card Holder Name
    [Tags]  SDK_Internal  Domestic_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  VISA
    Func_SDKPayment.Select Payment Method  DomesticCard
    Func_SDKPayment.Payment By Domestic Card - Show Warning With Invalid Information  ${alert_invalid_cardname}

SDK Payment Method - International Card - Input VISA
    [Tags]  SDK_Internal  International_Card  VISA
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  VISA
    Func_SDKPayment.Select Payment Method  InternationalCard
    Func_SDKPayment.Payment By International Card - Input Bank Card Information  ${card_holdername}  4111111111111111  ${expiry_date}  ${cvc}
    Func_SDKPayment.Payment By International Card - Verify Confirmation Order
    Func_SDKPayment.Payment By International Card - Input OTP And Verify Result Payment

SDK Payment Method - International Card
    [Tags]  SDK_Internal  International_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}
    Func_SDKPayment.Select Payment Method  InternationalCard
    Func_SDKPayment.Payment By International Card - Input Bank Card Information  ${card_holdername}  4111111111111111  ${expiry_date}  ${cvc}
    Func_SDKPayment.Payment By International Card - Verify Confirmation Order
    Func_SDKPayment.Payment By International Card - Input OTP And Verify Result Payment

SDK Payment Method - International Card - Invalid BankCode
    [Tags]  SDK_Internal  International_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  ERP
    Func_SDKPayment.Select Payment Method  InternationalCard
    Func_SDKPayment.Payment By International Card - Return Failure Result

SDK Payment Method - International Card - Invalid Card Holder Name
    [Tags]  SDK_Internal  International_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  VISA
    Func_SDKPayment.Select Payment Method  InternationalCard
    Func_SDKPayment.Payment By International Card - Input Bank Card Information  fgdftr  4111111111111111  ${expiry_date}  ${cvc}
    Func_SDKPayment.Payment By International Card - Show Warning With Invalid Information  ${alert_invalid_cardname}

SDK Payment Method - International Card - Invalid Card ExpiryDate
    [Tags]  SDK_Internal  International_Card
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  VISA
    Func_SDKPayment.Select Payment Method  InternationalCard
    Func_SDKPayment.Payment By International Card - Input Bank Card Information  ${card_holdername}  4111111111111111  1117  ${cvc}
    Func_SDKPayment.Payment By International Card - Show Warning With Invalid Information  ${alert_invalid_expirydate}

SDK Payment Method - Credit Installment - Input STB
    [Tags]  SDK_Internal  Credit_Installment  STB
    Func_SDKPayment.Create Order For SDK Payment  ${installment_amount}  ${email}  ${phone}  STB
    Func_SDKPayment.Select Payment Method  Installment
    Func_SDKPayment.Payment By Credit Installment - Input Bank Card Information - STB  ${card_holdername}  ${installment_cardnumber}  12  ${expiry_date}  ${cvc}
    Func_SDKPayment.Payment By Credit Installment - Verify Confirmation Order
    Func_SDKPayment.Payment By Credit Installment - Verify Result Payment

SDK Payment Method - Credit Installment
    [Tags]  SDK_Internal  Credit_Installment
    Func_SDKPayment.Create Order For SDK Payment  ${installment_amount}  ${email}  ${phone}
    Func_SDKPayment.Select Payment Method  Installment
    Func_SDKPayment.Payment By Credit Installment - Input Bank Card Information - STB  ${card_holdername}  ${installment_cardnumber}  6  ${expiry_date}  ${cvc}
    Func_SDKPayment.Payment By Credit Installment - Verify Confirmation Order
    Func_SDKPayment.Payment By Credit Installment - Verify Result Payment

SDK Payment Method - Credit Installment - Input STB And Select Muiltiple Methods
    [Tags]  SDK_Internal  Credit_Installment  STB
    Func_SDKPayment.Create Order For SDK Payment  ${installment_amount}  ${email}  ${phone}  STB
    Func_SDKPayment.Select Payment Method  Installment,DomesticCard,eWallet
    Func_SDKPayment.Payment By Credit Installment - Input Bank Card Information - STB  ${card_holdername}  ${installment_cardnumber}  12  ${expiry_date}  ${cvc}  Installment
    Func_SDKPayment.Payment By Credit Installment - Verify Confirmation Order
    Func_SDKPayment.Payment By Credit Installment - Verify Result Payment

SDK Payment Method - Credit Installment - Select Muiltiple Methods
    [Tags]  SDK_Internal  Credit_Installment
    Func_SDKPayment.Create Order For SDK Payment  ${installment_amount}  ${email}  ${phone}
    Func_SDKPayment.Select Payment Method  Installment,DomesticCard,eWallet
    Func_SDKPayment.Payment By Credit Installment - Input Bank Card Information - STB  ${card_holdername}  ${installment_cardnumber}  6  ${expiry_date}  ${cvc}  Installment
    Func_SDKPayment.Payment By Credit Installment - Verify Confirmation Order
    Func_SDKPayment.Payment By Credit Installment - Verify Result Payment

SDK Payment Method - Credit Installment - Unsupported Bank Code
    [Tags]  SDK_Internal  Credit_Installment
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  AGB
    Func_SDKPayment.Select Payment Method  Installment
    Func_SDKPayment.Payment By Credit Installment - Return Failure Result

SDK Payment Method - Credit Installment - Invalid Bank Code
    [Tags]  SDK_Internal  Credit_Installment
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  ERP
    Func_SDKPayment.Select Payment Method  Installment
    Func_SDKPayment.Payment By Credit Installment - Return Failure Result

SDK Payment Method - Credit Installment - Amount Smaller Than Min Allowed Value
    [Tags]  SDK_Internal  Credit_Installment
    Func_SDKPayment.Create Order For SDK Payment  2900000  ${email}  ${phone}  STB
    Func_SDKPayment.Select Payment Method  Installment
    Func_SDKPayment.Payment By Credit Installment - Return Failure Result

External SDK Payment Method - Domestic Card
    [Tags]  SDK_External  Domestic_Card
    pause execution
    common.Browser Chrome
    common.Begin Testing Android SDK Payment
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  STB
    Func_SDKPayment.Select Payment Method  DomesticCard
    Func_SDKPayment.External Payment By Domestic Card - STB  ${domestic_stb_card}  ${card_holdername}  ${phone}  ${email}

External SDK Payment Method - International Card
    [Tags]  SDK_External  International_Card
    common.Browser Chrome
    common.Begin Testing Android SDK Payment
    Func_SDKPayment.Create Order For SDK Payment  ${amount}  ${email}  ${phone}  VISA
    Func_SDKPayment.Select Payment Method  InternationalCard
    Func_SDKPayment.External Payment By International Card  ${card_holdername}  4111111111111111  ${expiry_date}  ${cvc}  ${phone}  ${email}

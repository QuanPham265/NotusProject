*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
${ID_SDK_Init_Amount}                   id=vn.payoo.paymentsdk.sample.dev.debug:id/cash
${ID_SDK_Init_Email}                    id=vn.payoo.paymentsdk.sample.dev.debug:id/email
${ID_SDK_Init_Phone}                    id=vn.payoo.paymentsdk.sample.dev.debug:id/phone
${ID_SDK_Init_UserID}                   id=vn.payoo.paymentsdk.sample.dev.debug:id/user_id
${ID_SDK_Init_AutToken}                 id=vn.payoo.paymentsdk.sample.dev.debug:id/auth_token
${ID_SDK_Init_BankCode}                 id=vn.payoo.paymentsdk.sample.dev.debug:id/bank_code

${SDK_Init_Domestic}                    id=vn.payoo.paymentsdk.sample.dev.debug:id/cb_domestic
${SDK_Init_International}               id=vn.payoo.paymentsdk.sample.dev.debug:id/cb_international
${SDK_Init_eWallet}                     id=vn.payoo.paymentsdk.sample.dev.debug:id/cb_eWallet
${SDK_Init_PayAtStore}                  id=vn.payoo.paymentsdk.sample.dev.debug:id/cb_payAtStore
${SDK_Init_Installment}                 id=vn.payoo.paymentsdk.sample.dev.debug:id/cb_installment

${SDK_Lang_vni}         id=vn.payoo.paymentsdk.sample.dev.debug:id/radio_vi
${SDK_Lang_eng}         id=vn.payoo.paymentsdk.sample.dev.debug:id/radio_en
${SDK_Init_Btn_Pay}     id=vn.payoo.paymentsdk.sample.dev.debug:id/button

${SDK_PaymentMethod_DomesticCard}               xpath=//*[contains(@text,'DOMESTIC CARD')]
${SDK_PaymentMethod_InternationalCard}          xpath=//*[contains(@text,'INTERNATIONAL CARD')]
${SDK_PaymentMethod_PayAtStore}                 xpath=//*[contains(@text,'PAY@STORE')]
${SDK_PaymentMethod_eWallet}                    xpath=//*[contains(@text,'PAYOO E-WALLET')]
${SDK_PaymentMethod_Installment}                xpath=//*[contains(@text,'CREDIT CARD INSTALMENTS')]

# SDK External
${SDK_PaymentMethod_International_SelectBank}       xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.TextView
${SDK_PaymentMethod_International_VISA}             xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[1]
${SDK_PaymentMethod_International_MASTERCARD}       xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[2]
${SDK_PaymentMethod_International_JCB}              xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[3]

${SDK_PaymentMethod_Domestic_SelectBank}            xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.TextView
${SDK_PaymentMethod_Domestic_Sacombank}             xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[5]
${SDK_PaymentMethod_Domestic_ABBank}                xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[6]

${SDK_PaymentMethod_Installment_SelectBank}         xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.TextView
${SDK_PaymentMethod_Installment_Sacombank}          xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[3]
${SDK_PaymentMethod_Installment_Citibank}           xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.ImageView[18]

*** Keywords ***
Wait App SDK Payment Loaded
    wait until element is visible  ${ID_SDK_Init_Amount}  timeout=60s

Select Language English
    scroll  ${SDK_Init_Installment}  ${ID_SDK_Init_Amount}
    click element  ${SDK_Lang_eng}

Clean Up All Text Box
    clear text  ${ID_SDK_Init_Amount}
    clear text  ${ID_SDK_Init_Email}
    clear text  ${ID_SDK_Init_Phone}

Fill Init Amount
    [Arguments]  ${amount}
    input text  ${ID_SDK_Init_Amount}  ${amount}

Fill Init Email
    [Arguments]  ${email}
    input text  ${ID_SDK_Init_Email}  ${email}

Fill Init Phone
    [Arguments]  ${phone}
    input text  ${ID_SDK_Init_Phone}  ${phone}

Fill Init User_ID
    [Arguments]  ${user_id}
    input text  ${ID_SDK_Init_UserID}  ${user_id}

Fill Init Aut Token
    [Arguments]  ${aut_token}
    input text  ${ID_SDK_Init_AutToken}  ${aut_token}

Fill Init Bank Code
    [Arguments]  ${bank_code}
    input text  ${ID_SDK_Init_BankCode}  ${bank_code}

Init Select Payment Method Domestic Card
    click element    ${SDK_Init_Domestic}

Init Select Payment Method Internation Card
    click element    ${SDK_Init_International}

Init Select Payment Method eWallet
    click element    ${SDK_Init_eWallet}

Init Select Payment Method Pay At Store
    click element    ${SDK_Init_PayAtStore}

Init Select Payment Method Installment
    click element    ${SDK_Init_Installment}

Init Select Multiple Payment Method
    [Arguments]  ${domestic_card}=Disable  ${international_card}=Disable  ${ewallet}=Disable  ${payatstore}=Disable  ${installment}=Disable
    run keyword if      '${domestic_card}' != 'Disable'                 Init Select Payment Method Domestic Card
    run keyword if      '${international_card}' != 'Disable'            Init Select Payment Method Internation Card
    run keyword if      '${ewallet}' != 'Disable'                       Init Select Payment Method eWallet
    run keyword if      '${payatstore}' != 'Disable'                    Init Select Payment Method Pay At Store
    run keyword if      '${installment}' != 'Disable'                   Init Select Payment Method Installment

Init Select Payment Method
    [Arguments]  ${payment_method}
    run keyword if  '${payment_method}' == 'DomesticCard'               Init Select Payment Method Domestic Card
    run keyword if  '${payment_method}' == 'InternationalCard'          Init Select Payment Method Internation Card
    run keyword if  '${payment_method}' == 'eWallet'                    Init Select Payment Method eWallet
    run keyword if  '${payment_method}' == 'Pay@store'                  Init Select Payment Method Pay At Store
    run keyword if  '${payment_method}' == 'Installment'                Init Select Payment Method Installment

Verify Show Payment Method
    [Arguments]  ${payment_method}
    wait until page contains  Payment method  timeout=10s
    run keyword if  '${payment_method}' == 'DomesticCard'               element should be visible  ${SDK_PaymentMethod_DomesticCard}
    run keyword if  '${payment_method}' == 'InternationalCard'          element should be visible  ${SDK_PaymentMethod_InternationalCard}
    run keyword if  '${payment_method}' == 'Pay@store'                  element should be visible  ${SDK_PaymentMethod_PayAtStore}
    run keyword if  '${payment_method}' == 'eWallet'                    element should be visible  ${SDK_PaymentMethod_eWallet}
    run keyword if  '${payment_method}' == 'Installment'                element should be visible  ${SDK_PaymentMethod_Installment}

Screen Payment Method - Select Method
    [Arguments]  ${payment_method}
    wait until page contains  Payment method  timeout=10s
    run keyword if  '${payment_method}' == 'DomesticCard'               click element  ${SDK_PaymentMethod_DomesticCard}
    run keyword if  '${payment_method}' == 'InternationalCard'          click element  ${SDK_PaymentMethod_InternationalCard}
    run keyword if  '${payment_method}' == 'Pay@store'                  click element  ${SDK_PaymentMethod_PayAtStore}
    run keyword if  '${payment_method}' == 'eWallet'                    click element  ${SDK_PaymentMethod_eWallet}
    run keyword if  '${payment_method}' == 'Installment'                click element  ${SDK_PaymentMethod_Installment}

Click Button Pay
    click element  ${SDK_Init_Btn_Pay}

Click Button Back And Close Notification
    click element  xpath=//android.widget.ImageButton[@content-desc="‎‏‎‎‎‎‎‏‎‏‏‏‎‎‎‎‎‏‎‎‏‎‎‎‎‏‏‏‏‏‎‏‏‎‏‏‎‎‎‎‏‏‏‏‏‏‏‎‏‏‏‏‏‎‏‎‎‏‏‎‏‎‎‎‎‎‏‏‏‎‏‎‎‎‎‎‏‏‎‏‏‎‎‏‎‏‎‏‏‏‏‏‎‎Navigate up‎‏‎‎‏‎"]
    wait until element is visible  id=android:id/button1  timeout=10s
    click element  id=android:id/button1

Get Result Payment And Close Notification
    [Arguments]  ${exp_result}=SUCCESS
    wait until element is visible  id=android:id/button1  timeout=30s
    ${return_code} =  get text  id=vn.payoo.paymentsdk.sample.dev.debug:id/alertTitle
    should be equal as strings  ${return_code}  ${exp_result}
    click element  id=android:id/button1

Choose International Card - VISA
    wait until page contains  Payment method  timeout=10s
    click element  ${SDK_PaymentMethod_International_VISA}

Choose Domestic Card - Sacombank
    wait until page contains  Payment method  timeout=10s
    click element  ${SDK_PaymentMethod_Domestic_Sacombank}

Choose Credit Installment - Sacombank
    wait until page contains  Payment method  timeout=10s
    click element  ${SDK_PaymentMethod_Installment_Sacombank}
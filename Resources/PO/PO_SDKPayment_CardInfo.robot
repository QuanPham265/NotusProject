*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
${ID_SDK_CardInfo_CardNumber}                   id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_card_number
${ID_SDK_CardInfo_CardHolderName}               id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_card_holder_name
${ID_SDK_CardInfo_ExpiryDate}                   id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_card_credit_expiration_date
${ID_SDK_CardInfo_ExpiryDate_Int}               id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_card_expiration_date
${ID_SDK_CardInfo_CVC}                          id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_card_cvv

# Contact Information
${ID_SDK_CardInfo_Phone}                        id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_customer_phone
${ID_SDK_CardInfo_Email}                        id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_customer_email

${ID_SDK_CardInfo_Btn_Continue}                 id=vn.payoo.paymentsdk.sample.dev.debug:id/button_continue
${ID_SDK_CardInfo_Estimate_Amount}              id=vn.payoo.paymentsdk.sample.dev.debug:id/text_estimated_amount


${ID_SDK_CardInfo_Periods}                      id=vn.payoo.paymentsdk.sample.dev.debug:id/spnPeriods
${ID_SDK_CardInfo_Installment_Month}            xpath=/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.TextView[@text='%month%']

# Notification
${ID_SDK_CardInfo_Alert_Message}                id=android:id/message

*** Keywords ***
Wait Card Information Loaded
    wait until element is visible  ${ID_SDK_CardInfo_CardNumber}  timeout=20s

Fill Card Number
    [Arguments]  ${card_number}
    input text   ${ID_SDK_CardInfo_CardNumber}  ${card_number}

Fill Domestic Card Number - BankCode Number
    [Arguments]  ${bank_code_no}
    @{characters} =  split string to characters  ${bank_code_no}
    : FOR    ${char}    IN   @{characters}
    \   input text   ${ID_SDK_CardInfo_CardNumber}  ${char}

Fill Domestic Card Number - Suffix
    [Arguments]  ${suffix_card_number}
    input text   ${ID_SDK_CardInfo_CardNumber}  ${suffix_card_number}

Fill Card Holder Name
    [Arguments]  ${card_holder_name}
    input text   ${ID_SDK_CardInfo_CardHolderName}  ${card_holder_name}

Fill Phone
    [Arguments]  ${phone}
    input text   ${ID_SDK_CardInfo_Phone}  ${phone}

Fill Email
    [Arguments]  ${email}
    input text   ${ID_SDK_CardInfo_Email}  ${email}

Fill ExpiryDate
    [Arguments]  ${expiry_date}
    input text   ${ID_SDK_CardInfo_ExpiryDate}  ${expiry_date}

Fill ExpiryDate International
    [Arguments]  ${expiry_date}
    input text   ${ID_SDK_CardInfo_ExpiryDate_Int}  ${expiry_date}

Fill CVC
    [Arguments]  ${cvc}
    input text   ${ID_SDK_CardInfo_CVC}  ${cvc}

Get Available Period Installment
    click element  ${ID_SDK_CardInfo_Periods}
    ${count} =  get matching xpath count  xpath=/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.TextView[@class='android.widget.TextView']
    log to console  ${\n}${count}

Choose Period Installment
    [Arguments]  ${months}
    click element  ${ID_SDK_CardInfo_Periods}
    sleep  1.5s
    ${installment_month} =  replace string  ${ID_SDK_CardInfo_Installment_Month}  %month%  ${months}
    click element  ${installment_month}

Click Button Continue
    click element    ${ID_SDK_CardInfo_Btn_Continue}

Get Message Of Alert
    ${message} =  get text  ${ID_SDK_CardInfo_Alert_Message}
    [Return]  ${message}
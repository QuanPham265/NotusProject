*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
# Card Information
${ID_SDK_Cfrm_CardHolderName}               id=vn.payoo.paymentsdk.sample.dev.debug:id/text_card_holder_name
${ID_SDK_Cfrm_CardType}                     id=vn.payoo.paymentsdk.sample.dev.debug:id/text_card_type
${ID_SDK_Cfrm_CardNumber}                   id=vn.payoo.paymentsdk.sample.dev.debug:id/text_card_number

# Contact Information
${ID_SDK_Cfrm_Phone}                        id=vn.payoo.paymentsdk.sample.dev.debug:id/text_phone
${ID_SDK_Cfrm_Email}                        id=vn.payoo.paymentsdk.sample.dev.debug:id/text_email

# Payment Information
${ID_SDK_Cfrm_Payment}                      id=vn.payoo.paymentsdk.sample.dev.debug:id/text_payment
${ID_SDK_Cfrm_Fee}
${ID_SDK_Cfrm_Total}                        id=vn.payoo.paymentsdk.sample.dev.debug:id/text_total

# Button
${Btn_SDK_CardInfo_Continue}                id=vn.payoo.paymentsdk.sample.dev.debug:id/button_continue
${Btn_SDK_CardInfo_Back}                    xpath=//android.widget.ImageButton[@content-desc="‎‏‎‎‎‎‎‏‎‏‏‏‎‎‎‎‎‏‎‎‏‎‎‎‎‏‏‏‏‏‎‏‏‎‏‏‎‎‎‎‏‏‏‏‏‏‏‎‏‏‏‏‏‎‏‎‎‏‏‎‏‎‎‎‎‎‏‏‏‎‏‎‎‎‎‎‏‏‎‏‏‎‎‏‎‏‎‏‏‏‏‏‎‎Navigate up‎‏‎‎‏‎"]

# OTP
${Txtbox_SDK_Input_OTP}                     id=vn.payoo.paymentsdk.sample.dev.debug:id/edit_input
${SDK_Submit_OTP}                           id=android:id/button1

*** Keywords ***
Wait SDK Payment Page Confirmation Loaded
    wait until element is visible  ${ID_SDK_Cfrm_CardNumber}  timeout=20s

Click Button Continue
    click element    ${Btn_SDK_CardInfo_Continue}

Fill OTP And Complete Payment
    wait until element is visible    ${Txtbox_SDK_Input_OTP}  timeout=10s
    input text  ${Txtbox_SDK_Input_OTP}  123456
    click element  ${SDK_Submit_OTP}
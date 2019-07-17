*** Settings ***
Library  AppiumLibrary

*** Variables ***
# Screen Add Card
${ID_AddCard_CardNo}            id=vn.payoo.sandbox.debug:id/txtKCardNo
${ID_AddCard_CardName}          id=vn.payoo.sandbox.debug:id/txtKCardName
${ID_AddCard_CustomerID}        id=vn.payoo.sandbox.debug:id/txtCustomerIdNo
${ID_AddCard_Date}              id=vn.payoo.sandbox.debug:id/txtKReleaseDate

${ID_Btn_AddCard_Confirm}       id=vn.payoo.sandbox.debug:id/btnConfirm

# Popup
${AddCard_Popup_title}              id=vn.payoo.sandbox.debug:id/md_title
${AddCard_Popup_content}            id=vn.payoo.sandbox.debug:id/md_content
${AddCard_Popup_Btn_Positive}       id=vn.payoo.sandbox.debug:id/md_buttonDefaultPositive
${AddCard_Popup_Btn_Negative}       id=vn.payoo.sandbox.debug:id/md_buttonDefaultNegative
${AddCard_Popup_Input}              id=vn.payoo.sandbox.debug:id/etKInput


*** Keywords ***
Click Button Confirm Add Card
    click element  ${ID_Btn_AddCard_Confirm}

Click Button Submit OTP
    click element  ${AddCard_Popup_Btn_Positive}

Get Bank Card Number - Text
    ${bank_cardno} =  get text  ${ID_AddCard_CardNo}
    [Return]  ${bank_cardno}

Get Bank Card Number - State Edit   #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_AddCard_CardNo}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Card Number - State Display    #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_AddCard_CardNo}  displayed
    [Return]  ${state_displayed}

Get Bank Card Holder Name - Text
    ${bank_card_holdername} =  get text  ${ID_AddCard_CardName}
    [Return]  ${bank_card_holdername}

Get Bank Card Holder Name - State Edit  #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_AddCard_CardName}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Card Holder Name - State Display  #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_AddCard_CardName}  displayed
    [Return]  ${state_displayed}

Get Bank Customer Identity Card - Text
    ${customer_identity_card} =  get text  ${ID_AddCard_CustomerID}
    [Return]  ${customer_identity_card}

Get Bank Customer Identity Card - State Edit    #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_AddCard_CustomerID}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Customer Identity Card - State Display     #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_AddCard_CustomerID}  displayed
    [Return]  ${state_displayed}

Get Bank Card Date - Text
    ${bank_card_date} =  get text  ${ID_AddCard_Date}
    [Return]  ${bank_card_date}

Get Bank Card Date - State Edit     #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_AddCard_Date}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Card Date - State Display      #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_AddCard_Date}  displayed
    [Return]  ${state_displayed}

Input Bank Card Number
    [Arguments]  ${bank_cardno}
    input text  ${ID_AddCard_CardNo}  ${bank_cardno}

Input Bank Card Holder Name
    [Arguments]  ${bank_card_holdername}
    input text  ${ID_AddCard_CardName}  ${bank_card_holdername}

Input Bank Card Date
    [Arguments]  ${bank_card_date}
    input text  ${ID_AddCard_Date}  ${bank_card_date}

Input Bank Customer Identity Card
    [Arguments]  ${customer_identify_card}
    input text  ${ID_AddCard_CustomerID}  ${customer_identify_card}

Input OTP
    [Arguments]  ${otp}=123456
    wait until element is visible  ${AddCard_Popup_Input}  timeout=10s
    input text  ${AddCard_Popup_Input}  ${otp}

State OF Shown Error Popup
    ${state_shown_popup} =  run keyword and return status  wait until element is visible  ${AddCard_Popup_title}  timeout=5s
    [Return]  ${state_shown_popup}

Verify Screen Add Card Loaded
    wait until page contains element  ${ID_AddCard_CardNo}  timeout=10s
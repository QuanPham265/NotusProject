*** Settings ***
Library  AppiumLibrary

*** Variables ***
# Screen Add Card
${ID_EditCard_CardNo}            id=vn.payoo.sandbox.debug:id/txtKCardNo
${ID_EditCard_CardName}          id=vn.payoo.sandbox.debug:id/txtKCardName
${ID_EditCard_CustomerID}        id=vn.payoo.sandbox.debug:id/txtCustomerIdNo
${ID_EditCard_Date}              id=vn.payoo.sandbox.debug:id/txtKReleaseDate

${ID_Btn_EditCard_Confirm}       id=vn.payoo.sandbox.debug:id/btnConfirm
${ID_Btn_EditCard_Back}          xpath=//android.widget.ImageButton[@content-desc="‎‏‎‎‎‎‎‏‎‏‏‏‎‎‎‎‎‏‎‎‏‎‎‎‎‏‏‏‏‏‎‏‏‎‏‏‎‎‎‎‏‏‏‏‏‏‏‎‏‏‏‏‏‎‏‎‎‏‏‎‏‎‎‎‎‎‏‏‏‎‏‎‎‎‎‎‏‏‎‏‏‎‎‏‎‏‎‏‏‏‏‏‎‎Navigate up‎‏‎‎‏‎"]


*** Keywords ***
Click Button Confirm Edit Card
    click element  ${ID_Btn_EditCard_Confirm}

Click Button Back
    click element  ${ID_Btn_EditCard_Back}

Get Bank Card Number - Text
    ${bank_cardno} =  get text  ${ID_EditCard_CardNo}
    [Return]  ${bank_cardno}

Get Bank Card Number - State Edit   #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_EditCard_CardNo}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Card Number - State Display    #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_EditCard_CardNo}  displayed
    [Return]  ${state_displayed}

Get Bank Card Holder Name - Text
    ${bank_card_holdername} =  get text  ${ID_EditCard_CardName}
    [Return]  ${bank_card_holdername}

Get Bank Card Holder Name - State Edit  #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_EditCard_CardName}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Card Holder Name - State Display  #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_EditCard_CardName}  displayed
    [Return]  ${state_displayed}

Get Bank Customer Identity Card - Text
    ${customer_identity_card} =  get text  ${ID_EditCard_CustomerID}
    [Return]  ${customer_identity_card}

Get Bank Customer Identity Card - State Edit    #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_EditCard_CustomerID}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Customer Identity Card - State Display     #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_EditCard_CustomerID}  displayed
    [Return]  ${state_displayed}

Get Bank Card Date - Text
    ${bank_card_date} =  get text  ${ID_EditCard_Date}
    [Return]  ${bank_card_date}

Get Bank Card Date - State Edit     #true: can edit, false: block edit
    ${state_enabled_edit} =  get element attribute  ${ID_EditCard_Date}  enabled
    [Return]  ${state_enabled_edit}

Get Bank Card Date - State Display      #true: display, false: hidden
    ${state_displayed} =  get element attribute  ${ID_EditCard_Date}  displayed
    [Return]  ${state_displayed}

Input Bank Card Number
    [Arguments]  ${bank_cardno}
    input text  ${ID_EditCard_CardNo}  ${bank_cardno}

Input Bank Card Holder Name
    [Arguments]  ${bank_card_holdername}
    input text  ${ID_EditCard_CardName}  ${bank_card_holdername}

Input Bank Card Date
    [Arguments]  ${bank_card_date}
    input text  ${ID_EditCard_Date}  ${bank_card_date}
    
Input Bank Customer Identify Card
    [Arguments]  ${customer_identify_card}
    input text  ${ID_EditCard_CustomerID}  ${customer_identify_card}

Verify Screen Edit Card Loaded
    wait until page contains element  ${ID_EditCard_CardNo}  timeout=10s
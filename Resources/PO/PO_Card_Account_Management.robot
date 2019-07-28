*** Settings ***
Library  AppiumLibrary

*** Variables ***
${ID_CAM_MenuBar_Card}              xpath=//android.support.v7.app.ActionBar.Tab[@content-desc="Card"]
${ID_CAM_MenuBar_Account}           xpath=//android.support.v7.app.ActionBar.Tab[@content-desc="Bank account"]
${ID_CAM_MenuBar_Link}              xpath=//android.support.v7.app.ActionBar.Tab[@content-desc="Link Account"]

${ID_CAM_Btn_Modify_BankCard}       xpath=//android.view.ViewGroup[@resource-id='vn.payoo.sandbox.debug:id/fabMenu']/android.widget.ImageButton
${ID_CAM_Btn_AddCard}               id=vn.payoo.sandbox.debug:id/fabAdd
${ID_CAM_Btn_EditCard}              id=vn.payoo.sandbox.debug:id/fabEdit
${ID_CAM_Btn_RemoveCard}            id=vn.payoo.sandbox.debug:id/fabRemove

# Detail của Card đang chọn
${ID_CAM_Card_BankName}         id=vn.payoo.sandbox.debug:id/lblBankCardName
${ID_CAM_Card_No}               id=vn.payoo.sandbox.debug:id/lblCardNo
${ID_CAM_Card_Name}             xpath=//android.widget.TextView[@resource-id='vn.payoo.sandbox.debug:id/lblCardNo']/parent::*/parent::*/android.widget.LinearLayout[3]/android.widget.TextView[@resource-id='vn.payoo.sandbox.debug:id/lblCardName']
${ID_CAM_Card_Date}             id=vn.payoo.sandbox.debug:id/lblReleaseDate

# Detail của Link đang chọn
${ID_CAM_Link_BankName}         id=vn.payoo.sandbox.debug:id/lblBankNameOfAccount
${ID_CAM_Card_No}               id=vn.payoo.sandbox.debug:id/lblLinkCardNo
${ID_CAM_Card_Name}             id=vn.payoo.sandbox.debug:id/lblLinkCardHolder
${ID_CAM_Card_Date}             id=vn.payoo.sandbox.debug:id/lblLinkIDCard

# Detail của Account đang chọn
${ID_CAM_Account_BankName}      id=vn.payoo.sandbox.debug:id/lblBankNameOfAccount
${ID_CAM_Account_No}            id=vn.payoo.sandbox.debug:id/lblBankAccountNumber
${ID_CAM_Account_OwnerName}     id=vn.payoo.sandbox.debug:id/lblBankAccountName
${ID_CAM_Account_Branch}        id=vn.payoo.sandbox.debug:id/lblBranchName
${ID_CAM_Account_IDCard}        id=vn.payoo.sandbox.debug:id/lblLinkIDCard

# Popup
${CAM_Popup_title}              id=vn.payoo.sandbox.debug:id/md_title
${CAM_Popup_content}            id=vn.payoo.sandbox.debug:id/md_content
${CAM_Popup_Btn_Positive}       id=vn.payoo.sandbox.debug:id/md_buttonDefaultPositive
${CAM_Popup_Btn_Negative}       id=vn.payoo.sandbox.debug:id/md_buttonDefaultNegative

*** Keywords ***
Add Bank Card
    wait until element is visible   ${ID_CAM_Btn_Modify_BankCard}    timeout=5s
    click element                   ${ID_CAM_Btn_Modify_BankCard}
    wait until element is visible   ${ID_CAM_Btn_AddCard}            timeout=5s
    click element                   ${ID_CAM_Btn_AddCard}

Add Bank Link
    wait until element is visible   ${ID_CAM_Btn_Modify_BankCard}    timeout=5s
    click element                   ${ID_CAM_Btn_Modify_BankCard}
    wait until element is visible   ${ID_CAM_Btn_AddCard}            timeout=5s
    click element                   ${ID_CAM_Btn_AddCard}

Edit Bank Card
    wait until element is visible   ${ID_CAM_Btn_Modify_BankCard}    timeout=5s
    click element                   ${ID_CAM_Btn_Modify_BankCard}
    wait until element is visible   ${ID_CAM_Btn_EditCard}           timeout=5s
    click element                   ${ID_CAM_Btn_EditCard}

Edit Bank Link
    wait until element is visible   ${ID_CAM_Btn_Modify_BankCard}    timeout=5s
    click element                   ${ID_CAM_Btn_Modify_BankCard}
    wait until element is visible   ${ID_CAM_Btn_EditCard}           timeout=5s
    click element                   ${ID_CAM_Btn_EditCard}

Remove Bank Card
    wait until element is visible   ${ID_CAM_Btn_Modify_BankCard}    timeout=5s
    click element                   ${ID_CAM_Btn_Modify_BankCard}
    wait until element is visible   ${ID_CAM_Btn_RemoveCard}         timeout=5s
    click element                   ${ID_CAM_Btn_RemoveCard}
    wait until element is visible   ${CAM_Popup_Btn_Positive}        timeout=5s
    click element                   ${CAM_Popup_Btn_Positive}

Remove Bank Link
    wait until element is visible   ${ID_CAM_Btn_Modify_BankCard}    timeout=5s
    click element                   ${ID_CAM_Btn_Modify_BankCard}
    wait until element is visible   ${ID_CAM_Btn_RemoveCard}         timeout=5s
    click element                   ${ID_CAM_Btn_RemoveCard}
    wait until element is visible   ${CAM_Popup_Btn_Positive}        timeout=5s
    click element                   ${CAM_Popup_Btn_Positive}

Select Overview Bank Card
    wait until element is visible  ${ID_CAM_MenuBar_Card}  timeout=5s
    click element  ${ID_CAM_MenuBar_Card}

Select Overview Bank Account
    wait until element is visible  ${ID_CAM_MenuBar_Account}  timeout=5s
    click element  ${ID_CAM_MenuBar_Account}

Select Overview Bank Link
    wait until element is visible  ${ID_CAM_MenuBar_Link}  timeout=5s
    click element  ${ID_CAM_MenuBar_Link}

Get Selecting Bank Card - Bank Name
    ${card_bankname} =  get text  ${ID_CAM_Card_BankName}
    [Return]  ${card_bankname}

Get Selecting Bank Card - Number
    ${card_no} =  get text  ${ID_CAM_Card_No}
    [Return]  ${card_no}

Get Selecting Bank Card - Holder Name
    ${card_holdername} =  get text  ${ID_CAM_Card_Name}
    [Return]  ${card_holdername}

Get Selecting Bank Card - Date
    ${card_date} =  get text  ${ID_CAM_Card_Date}
    [Return]  ${card_date}

Get Selecting Bank Account - Bank Name
    ${account_bankname} =  get text  ${ID_CAM_Account_BankName}
    [Return]  ${account_bankname}

Get Selecting Bank Account - Number
    ${account_no} =  get text  ${ID_CAM_Account_No}
    [Return]  ${account_no}

Get Selecting Bank Account - Holder Name
    ${account_holdername} =  get text  ${ID_CAM_Account_OwnerName}
    [Return]  ${account_holdername}

Get Selecting Bank Account - Branch
    ${account_branch} =  get text  ${ID_CAM_Account_Branch}
    [Return]  ${account_branch}

Get Selecting Bank Account - IDCard
    ${account_id_card} =  get text  ${ID_CAM_Account_IDCard}
    [Return]  ${account_id_card}

Get State Of Button Add     #true: can tap, false: block tap
    ${state_btn_add} =  get element attribute  ${ID_CAM_Btn_AddCard}  enabled
    [Return]  ${state_btn_add}

Get State Of Button Edit     #true: can tap, false: block tap
    ${state_btn_edit} =  get element attribute  ${ID_CAM_Btn_EditCard}  enabled
    [Return]  ${state_btn_edit}

Get State Of Button Remove     #true: can tap, false: block tap
    ${state_btn_remove} =  get element attribute  ${ID_CAM_Btn_RemoveCard}  enabled
    [Return]  ${state_btn_remove}

Verify Screen Card/Account Management Loaded
    wait until element is visible  ${ID_CAM_MenuBar_Card}  timeout=5s
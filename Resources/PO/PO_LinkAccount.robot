*** Settings ***
Library  AppiumLibrary
Library  Dialogs

*** Variables ***
# Screen Menu Add/Modify/Remove Link Account
${Txt_PO_Loaded}                          xpath=//*[contains(@text,'Card/Account management')]
${ID_LinkAcc_Btn_Modify}                  xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.ImageButton
${ID_LinkAcc_Btn_Add}                     xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.ImageButton[1]  #id:vn.payoo.sandbox.debug:id/fabAdd
${ID_LinkAcc_Btn_Edit}                    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.ImageButton[2]
${ID_LinkAcc_Btn_Remove}                  xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.ImageButton[3]

# Bank SCB
${ID_LinkAcc_SCB}               xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/android.widget.LinearLayout/android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[5]/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.RelativeLayout
${ID_LinkType_Account}          xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.LinearLayout[2]/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.RadioButton
${ID_LinkType_Card}             xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.LinearLayout[2]/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]/android.widget.RadioButton
${ID_LinkType_BtnOK}            xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.TextView

# Screen Account Information
${ID_LinkAcc_AccNum}                    id=vn.payoo.sandbox.debug:id/txtKBankAccountNumber
${ID_LinkAcc_AccName}                   id=vn.payoo.sandbox.debug:id/txtKBankAccountName
${ID_LinkAcc_CardNo}                    id=vn.payoo.sandbox.debug:id/txtKCardNo
${ID_LinkAcc_CardName}                  id=vn.payoo.sandbox.debug:id/txtKCardName
${ID_LinkAcc_IDCard}                    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[3]/android.widget.FrameLayout/android.widget.EditText
${ID_LinkAcc_Btn_Link}                  id=vn.payoo.sandbox.debug:id/btnConfirm
${ID_LinkAcc_PopUp_Content}             id=vn.payoo.sandbox.debug:id/md_content
${ID_LinkAcc_PopUp_Title}               id=vn.payoo.sandbox.debug:id/md_title
${ID_LinkAcc_OTP}                       xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.ScrollView/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.EditText
${ID_LinkAcc_Btn_SendOTP}               xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.TextView[2]
${ID_LinkAcc_Btn_Confirm_Delete}        id=vn.payoo.sandbox.debug:id/md_buttonDefaultPositive

${ID_Cfrm_Link_FrameBankAccInfor}       id=vn.payoo.sandbox.debug:id/lnlBankAccountInfo
${ID_Cfrm_Link_BankName}                id=vn.payoo.sandbox.debug:id/lblBankNameOfAccount
${ID_Cfrm_Link_AccountNo}               id=vn.payoo.sandbox.debug:id/lblBankAccountNumber
${ID_Cfrm_Link_AccountName}             id=vn.payoo.sandbox.debug:id/lblBankAccountName
${ID_Cfrm_Link_IDCard}                  id=vn.payoo.sandbox.debug:id/lblLinkIDCard
${ID_Cfrm_Link_CardNo}                  id=vn.payoo.sandbox.debug:id/lblLinkCardNo
${ID_Cfrm_Link_CardName}                id=vn.payoo.sandbox.debug:id/lblLinkCardHolder

*** Keywords ***
Verify Screen Link Account Loaded
    wait until page contains element  ${ID_LinkAcc_Btn_Modify}  timeout=15s

Verify Screen Account Information Loaded
    wait until page contains  Account information  timeout=15s

Verify Screen Card Information Loaded
    wait until page contains  Card information  timeout=15s

Verify Frame Contains Bank Infor Loaded
    wait until element is visible  ${ID_Cfrm_Link_FrameBankAccInfor}  timeout=15s

# Screen Card/Account Management
Button Add Link Account
    click element  ${ID_LinkAcc_Btn_Modify}
    click element  ${ID_LinkAcc_Btn_Add}

Button Edit Link Account
    click element  ${ID_LinkAcc_Btn_Modify}
    click element  ${ID_LinkAcc_Btn_Edit}

Button Delete Link Account
    click element  ${ID_LinkAcc_Btn_Modify}
    click element  ${ID_LinkAcc_Btn_Remove}

Confirm Delete Link Account
    wait until element is visible  ${ID_LinkAcc_Btn_Confirm_Delete}  timeout=15s
    click element  ${ID_LinkAcc_Btn_Confirm_Delete}
    wait until page contains  Delete bank account successfully.  timeout=15s

Get Infor Linked Bank - Bank Name
    ${bankname} =  get text  ${ID_Cfrm_Link_BankName}
    [Return]  ${bankname}

Get Infor Linked Bank - Account No
    ${account_no} =  get text  ${ID_Cfrm_Link_AccountNo}
    [Return]  ${account_no}

Get Infor Linked Bank - Account Name
    ${account_name} =  get text  ${ID_Cfrm_Link_AccountName}
    [Return]  ${account_name}

Get Infor Linked Bank - Card No
    ${card_no} =  get text  ${ID_Cfrm_Link_CardNo}
    [Return]  ${card_no}

Get Infor Linked Bank - Card Name
    ${card_name} =  get text  ${ID_Cfrm_Link_CardName}
    [Return]  ${card_name}

Get Infor Linked Bank - ID Card
    ${id_card} =  get text  ${ID_Cfrm_Link_IDCard}
    [Return]  ${id_card}

# Screen Select Bank
Choose Bank - SCB
    wait until page contains element  ${ID_LinkAcc_SCB}
    click element    ${ID_LinkAcc_SCB}

Link Type - Account
    click element    ${ID_LinkType_Account}
    click element    ${ID_LinkType_BtnOK}

Link Type - Card
    click element    ${ID_LinkType_Card}
    click element    ${ID_LinkType_BtnOK}

# Screen Account/Card Information
Fill Account Number
    [Arguments]  ${acc_number}
    input text  ${ID_LinkAcc_AccNum}  ${acc_number}

Fill Account Name
    [Arguments]  ${acc_name}
    input text  ${ID_LinkAcc_AccName}  ${acc_name}

Fill Card Number
    [Arguments]  ${card_number}
    input text  ${ID_LinkAcc_CardNo}  ${card_number}

Fill Card Name
    [Arguments]  ${card_name}
    input text  ${ID_LinkAcc_CardName}  ${card_name}

Fill ID Card
    [Arguments]  ${idcard_number}
    input text  ${ID_LinkAcc_IDCard}  ${idcard_number}

Button Link
    click element    ${ID_LinkAcc_Btn_Link}

Get PopUp Content
    ${content} =  get text  ${ID_LinkAcc_PopUp_Content}
    [Return]  ${content}

Get PopUp Title
    ${title} =  get text  ${ID_LinkAcc_PopUp_Title}
    [Return]  ${title}

Enter OTP Sent From Bank
    [Arguments]  ${otp}
    wait until page contains element  ${ID_LinkAcc_OTP}  timeout=15s
    input text  ${ID_LinkAcc_OTP}  ${otp}
    click element  ${ID_LinkAcc_Btn_SendOTP}


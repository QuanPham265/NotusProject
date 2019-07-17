*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Library  String
Resource  ./PO/PO_Home.robot
Resource  ./PO/PO_LinkAccount.robot

*** Keywords ***
Select Link Account
    PO_Home.Select Link Acccount

Add Link Account SCB
    [Arguments]  ${acc_number}  ${acc_name}  ${idcard_number}
    PO_LinkAccount.Verify Screen Link Account Loaded
    PO_LinkAccount.Button Add Link Account
    PO_LinkAccount.Choose Bank - SCB
    PO_LinkAccount.Link Type - Account
    PO_LinkAccount.Verify Screen Account Information Loaded
    PO_LinkAccount.Fill Account Number  ${acc_number}
    PO_LinkAccount.Fill Account Name    ${acc_name}
    PO_LinkAccount.Fill ID Card         ${idcard_number}
    PO_LinkAccount.Button Link

Add Link Card SCB
    [Arguments]  ${card_number}  ${card_name}  ${idcard_number}
    PO_LinkAccount.Verify Screen Link Account Loaded
    PO_LinkAccount.Button Add Link Account
    PO_LinkAccount.Choose Bank - SCB
    PO_LinkAccount.Link Type - Card
    PO_LinkAccount.Verify Screen Card Information Loaded
    PO_LinkAccount.Fill Card Number  ${card_number}
    PO_LinkAccount.Fill Card Name    ${card_name}
    PO_LinkAccount.Fill ID Card      ${idcard_number}
    PO_LinkAccount.Button Link

Get Error Message
    ${content} =    PO_LinkAccount.Get PopUp Content
    ${title} =      PO_LinkAccount.Get PopUp Title
    log to console  ${\n}CONTENT POPUP: ${content}
    log to console  ${\n}TITLE POPUP: ${title}

Fill OTP And Complete Linking Bank
    [Arguments]  ${otp}
    PO_LinkAccount.Enter OTP Sent From Bank  ${otp}

Verify Link Bank Account  #Verify tên ngân hàng, số tài khoản, tên chủ tài khoản, chứng minh nhân dân
    [Arguments]  ${bankname}  ${account_no}  ${account_name}  ${id_card}
    PO_LinkAccount.Verify Frame Contains Bank Infor Loaded
    ${appshow_bankname} =       PO_LinkAccount.Get Infor Linked Bank - Bank Name
    ${appshow_account_no} =     PO_LinkAccount.Get Infor Linked Bank - Account No
    ${appshow_account_name} =   PO_LinkAccount.Get Infor Linked Bank - Account Name
    ${appshow_id_card} =        PO_LinkAccount.Get Infor Linked Bank - ID Card

    log many  ${bankname}           ${account_no}           ${account_name}             ${id_card}
    log many  ${appshow_bankname}   ${appshow_account_no}   ${appshow_account_name}     ${appshow_id_card}

#    should be equal  ${bankname}        ${appshow_bankname}
    should be equal  ${account_no}      ${appshow_account_no}
    should be equal  ${account_name}    ${appshow_account_name}
    should be equal  ${id_card}         ${appshow_id_card}

Verify Link Bank Card  #Verify tên ngân hàng, số thẻ, tên in trên thẻ, chứng minh nhân dân
    [Arguments]  ${bankname}  ${card_no}  ${card_name}  ${id_card}
    PO_LinkAccount.Verify Frame Contains Bank Infor Loaded
    ${appshow_bankname} =       PO_LinkAccount.Get Infor Linked Bank - Bank Name
    ${appshow_card_no} =        PO_LinkAccount.Get Infor Linked Bank - Card No
    ${appshow_card_name} =      PO_LinkAccount.Get Infor Linked Bank - Card Name
    ${appshow_id_card} =        PO_LinkAccount.Get Infor Linked Bank - ID Card

    log many  ${bankname}           ${card_no}           ${card_name}             ${id_card}
    log many  ${appshow_bankname}   ${appshow_card_no}   ${appshow_card_name}     ${appshow_id_card}

    ${appshow_card_no_last4digits} =    get substring  ${appshow_card_no}  -4
    ${card_no_last4digits} =            get substring  ${card_no}  -4

#    should be equal  ${bankname}        ${appshow_bankname}
    should be equal  ${card_no_last4digits}      ${appshow_card_no_last4digits}
    should be equal  ${card_name}                ${appshow_card_name}
    should be equal  ${id_card}                  ${appshow_id_card}

Delete Link Bank Account/Card
    PO_LinkAccount.Verify Frame Contains Bank Infor Loaded
    PO_LinkAccount.Button Delete Link Account
    PO_LinkAccount.Confirm Delete Link Account

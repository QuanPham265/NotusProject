*** Settings ***
Library  Dialogs
Resource  ../Resources/common.robot
Resource  ../Resources/Func_Login.robot
Resource  ../Resources/Func_ManageBank_CardAccount.robot

Test Setup          common.Test App Android
Test Teardown       common.End App

*** Variables ***
&{data_kyc_cxm}  ewallet_name=qtest_kyc_5   full_name=QUAN PHAM  id_card=244875231

# How to run Script
# robot -d /Users/notuspham/Downloads/Log_RF_KYC -i test tests/BankAccount.robot

*** Test Cases ***
KYC Chưa xác minh - Add Card - Giới hạn danh sách Bank khi thêm thẻ
    [Documentation]  AddCard_KYC_CXM_Bank_List
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Verify Limit Bank Card Allow Adding For eWallet Without Complete KYC

KYC Chưa xác minh - Add Card - Số thẻ mới hợp lệ
    [Documentation]  AddCard_KYC_CXM_Add_1
    [Tags]  test
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username  &{data_kyc_cxm}[full_name]  &{data_kyc_cxm}[id_card]
    Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully
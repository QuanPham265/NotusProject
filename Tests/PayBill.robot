*** Settings ***
Library  Dialogs
Resource  ../Resources/common.robot
Resource  ../Resources/Func_Login.robot
Resource  ../Resources/Func_PayBill.robot
Resource  ../Resources/Func_PaymentMethod.robot

#Test Setup          common.Begin Testing Android
#Test Teardown       common.End Testing

*** Variables ***


# How to run Script
# robot -d C:/results/MobileApp -i test tests/PayBill.robot

*** Test Cases ***
Thanh toan hoa don Telephone - VNPT
    [Tags]  Telephone_VNPT
    common.Begin Testing Android
    Func_Login.Unlock To Access App Payoo
    Func_PayBill.Search Bill - Telephone - VNPT
    Func_PaymentMethod.Select Payment Method EWALLET
    Func_PaymentMethod.Verify Payment Status

Thanh toan hoa don Truyen Hinh - SCTV HCM
    [Tags]  Television_SCTV_HCM  test
    common.Begin Testing Android
    Func_Login.Unlock To Access App Payoo

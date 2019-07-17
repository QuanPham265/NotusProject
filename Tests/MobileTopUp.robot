*** Settings ***
Library  Dialogs
Resource  ../Resources/common.robot
Resource  ../Resources/Func_Login.robot
Resource  ../Resources/Func_MobileTopUp.robot
Resource  ../Resources/Func_PaymentMethod.robot

Test Setup          common.Begin Testing Android
#Test Teardown       common.End Testing

*** Variables ***

# How to run Script
# robot -d C:/results/MobileApp tests/MobileTopUp.robot

*** Test Cases ***
Nạp tiền Mobifone 20k
    Func_Login.Unlock To Access App Payoo
    Func_MobileTopUp.TopUp Mobifone 20k
    Func_PaymentMethod.Select Payment Method EWALLET

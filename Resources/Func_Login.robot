*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Resource  ./PO/PO_Login.robot

*** Variables ***


*** Keywords ***
Unlock To Access App Payoo
    PO_Login.Cancel PopUp Unlock By FingerPrint
    PO_Login.Input Passcode To Unlock

Input Name eWallet And Password To Login
    [Arguments]  ${username}  ${password}
    pause execution
    PO_Login.Click Button Login
    PO_Login.Input eWallet      ${username}
    PO_Login.Input Password     ${password}



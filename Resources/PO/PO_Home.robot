*** Settings ***
Library  AppiumLibrary
Library  Dialogs

*** Variables ***
${ID_Ser_PayBill}           xpath=//*[contains(@text,'BILL PAYMENT')]
${ID_Ser_MobileTopUp}       xpath=//*[contains(@text,'MOBILE TOP-UP')]
${ID_Ser_Transfer}          xpath=//*[contains(@text,'TRANSFER')]
${ID_eWalletName}           id=vn.payoo.sandbox.debug:id/lblWalletName
${ID_Home_LinkedAccount}     id=vn.payoo.sandbox.debug:id/btnLink


*** Keywords ***
Select Service PayBill
    wait until page contains  BILL PAYMENT  timeout=60s
    click element  ${ID_Ser_PayBill}

Select Service Mobile TopUp
    wait until page contains  MOBILE TOP-UP  timeout=60s
    click element  ${ID_Ser_MobileTopUp}

Verify State Logged In
    wait until element is visible    ${ID_eWalletName}  timeout=60s

Select Link Acccount
    wait until page contains  LINK ACCOUNT  timeout=60s
    click element  ${ID_Home_LinkedAccount}
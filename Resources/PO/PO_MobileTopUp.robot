*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
## Screen SELECT PRICE MOBILE CARD
${ID_Prepaid}               id=vn.payoo.sandbox.debug:id/optPrepaid
${ID_PostPaid}              xpath=//*[contains(@text,'Postpaid')]
${ID_TxtBox_Phone}          id=vn.payoo.sandbox.debug:id/etKPhoneNumber
${ID_PriceCard_20k}         xpath=//*[contains(@text,'20.000 đ')]
${ID_btn_Next}              id=vn.payoo.sandbox.debug:id/btnNext


*** Keywords ***
Select Type Prepaid
    wait until element is visible  ${ID_Prepaid}  timeout=5s
    click element  ${ID_Prepaid}
    sleep  1s

Select Type PostPaid
    wait until element is visible  ${ID_PostPaid}  timeout=5s
    click element  ${ID_PostPaid}

Enter Phone To TopUp
    [Arguments]  ${phone}
    wait until element is visible  ${ID_TxtBox_Phone}  timeout=5s
    input text  ${ID_TxtBox_Phone}    ${phone}
    sleep  0.3s

Select Card Price
    wait until element is visible  ${ID_PriceCard_20k}  timeout=10s
    click element  ${ID_PriceCard_20k}
    sleep  0.3s

Click Button Next
    click element  ${ID_btn_Next}



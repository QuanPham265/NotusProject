*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Resource  ./PO/PO_Home.robot
Resource  ./PO/PO_PayBill.robot
Resource  ./PO/PO_ResultPayment.robot
Resource  ./PO/PO_AddCard.robot

*** Keywords ***
Select Payment Method EWALLET
    ## Screen Payment Method
    PO_PayBill.Select Payment Method  EWALLET
    ## Screen Contact Information
#    PO_PayBill.Click Button Continue
    ## Screen Payment Confirmation
    PO_PayBill.Accept Payment Policy
    PO_PayBill.Click Button PAY

Select Payment Method DOMESTIC CARD With New Bank Card
    [Arguments]  ${bank_card_number}  ${bank_card_holdername}  ${bank_card_issuedate}
    ## Screen Payment Method
    PO_PayBill.Select Payment Method  DOMESTIC
    ## Screen Add Cart
    PO_AddCard.Click Button Enter Bank Card Information
    PO_AddCard.Input Bank Card Number  ${bank_card_number}
    PO_AddCard.Click Btn Next
    PO_AddCard.Input Bank Card Holder Name     ${bank_card_holdername}
    PO_AddCard.Input Bank Card Issue Date      ${bank_card_issuedate}
    PO_AddCard.Click Btn Next
    PO_PayBill.Accept Payment Policy
    PO_PayBill.Click Button PAY

Get Detail Notification
    [Arguments]  ${exp_return_code_message}
    ${bln_notification} =  PO_PayBill.Payment confirmation - Exist Notification
    ${title_app} =      PO_PayBill.Payment confirmation - Get Title Notification
    ${content_app} =    PO_PayBill.Payment confirmation - Get Content Notification
    should be equal as strings  ${content_app}  @{exp_return_code_message}[1]

Enter OTP Sent From Bank
    PO_PayBill.Payment confirmation - Exist OTP
    PO_PayBill.Enter OTP Sent From Bank  SUNSET

Enter OTP And Return Detail Notification If Occur
    ${bln_otp} =  PO_PayBill.Payment confirmation - Exist OTP
    run keyword if  ${bln_otp}  PO_PayBill.Enter OTP Sent From Bank  SUNSET
    ...    ELSE    Get Detail Notification

Verify Payment Status   # Screen Payment Successfully
    PO_ResultPayment.Get All Information Of Payment PayBill
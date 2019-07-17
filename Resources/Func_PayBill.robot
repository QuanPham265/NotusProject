*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Resource  ./PO/PO_Home.robot
Resource  ./PO/PO_PayBill.robot
Resource  ./PO/PO_ResultPayment.robot
Resource  ./PO/PO_AddCard.robot

*** Variables ***


*** Keywords ***
Search Bill - Telephone - VNPT
#    PO_Home.Verify State Logged In
    ## Screen Search Bill
    PO_Home.Select Service PayBill
    PO_PayBill.Select Service  Telephone
    PO_PayBill.Select Biller   Telephone  VNPT
    PO_PayBill.Input CustomerCode
    PO_PayBill.Click Button Continue
    PO_PayBill.Select City - Telephone - VNPT
    PO_PayBill.Click Button Continue

Verify Bill Payment - Telephone - VNPT
    PO_PayBill.Select Period To Pay
    PO_PayBill.Click Button Continue

Search Bill - Television - SCTV.HCM
    ## Screen Search Bill
    PO_Home.Select Service PayBill
    PO_PayBill.Select Service  Television
    PO_PayBill.Select Biller   Television  SCTVHCM
    PO_PayBill.Input CustomerCode
    PO_PayBill.Click Button Continue

Verify Bill Payment - Television - SCTV.HCM     # verify all fiels dislpay corresspongidn biller
    PO_PayBill.Select Period To Pay
    PO_PayBill.Click Button Continue


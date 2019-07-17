*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  Collections
Resource  ./PO/PO_Home.robot
Resource  ./PO/PO_MobileTopUp.robot
Resource  ./PO/PO_ResultPayment.robot
Resource  ./PO/PO_AddCard.robot
Resource  ./PO/PO_PayBill.robot


*** Variables ***


*** Keywords ***
TopUp Mobifone 20k
#    PO_Home.Verify State Logged In
    ## Screen Search Bill
    PO_Home.Select Service Mobile TopUp
    PO_MobileTopUp.Enter Phone To TopUp  0768166265
    PO_MobileTopUp.Select Type Prepaid
    PO_MobileTopUp.Select Card Price
    PO_MobileTopUp.Click Button Next




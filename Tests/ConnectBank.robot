*** Settings ***
Library  Dialogs
Resource  ../Resources/common.robot
Resource  ../Resources/Func_Login.robot
Resource  ../Resources/Func_PayBill.robot
Resource  ../Resources/Func_PaymentMethod.robot
Resource  ../Resources/Func_LinkAccount.robot
Resource  ../DataSystem/ReturnCode/ReturnCode_Paybill.robot

Test Setup          common.Begin Testing Android
Test Teardown       common.End Testing

*** Variables ***
# SCB
&{scb_card_work}     card_number_1=9704290806086754     card_name_1=NGUYEN THI MY THU   account_number_1=0010100044380001  id_card_1=300401615
...                  card_number_2=9704290400803990     card_name_2=NGUYEN THI MY THU   account_number_2=0010100044380001  id_card_2=300401615      #fail
...                  card_number_3=9704291509418617     card_name_3=NGUYEN THI HUYNH    account_number_3=0010100421970001  id_card_3=026077067

${invalid_name}     weqw dsd
${invalid_number}   9704291503490578

# How to run Script
# robot -d C:/results/MobileApp -i test tests/ConnectBank.robot

*** Test Cases ***
#Init Test Case
#    Install New App
#    Choose Language English
#    Choose Passcode 8888
#    Sign In eWallet Testing this feature: quanpham_ps

Gateway Payment - Paybill - Thanh toán thành công
    [Documentation]  GW_Payment_01
    [Tags]  GW_Payment
    Func_Login.Unlock To Access App Payoo
    Func_PayBill.Search Bill - Television - SCTV.HCM
    Func_PayBill.Verify Bill Payment - Television - SCTV.HCM
    Func_PaymentMethod.Select Payment Method DOMESTIC CARD With New Bank Card  &{success_card}[card_number]  &{success_card}[card_name]  &{success_card}[card_issuedate]
    Func_PaymentMethod.Enter OTP Sent From Bank
    Func_PaymentMethod.Verify Payment Status
    pause execution

Gateway Payment - Paybill - Nhập sai tên chủ thẻ
    [Documentation]  GW_Payment_02
    [Tags]  GW_Payment
    Func_Login.Unlock To Access App Payoo
    Func_PayBill.Search Bill - Television - SCTV.HCM
    Func_PayBill.Verify Bill Payment - Television - SCTV.HCM
    Func_PaymentMethod.Select Payment Method DOMESTIC CARD With New Bank Card  &{success_card}[card_number]  ${invalid_name}  &{success_card}[card_issuedate]
    Func_PaymentMethod.Get Detail Notification  &{ConnectBank}[VerifyCard_HolderName]

Gateway Payment - Paybill - Nhập sai số thẻ
    [Documentation]  GW_Payment_03
    [Tags]  GW_Payment
    Func_Login.Unlock To Access App Payoo
    Func_PayBill.Search Bill - Television - SCTV.HCM
    Func_PayBill.Verify Bill Payment - Television - SCTV.HCM
    Func_PaymentMethod.Select Payment Method DOMESTIC CARD With New Bank Card  ${invalid_number}  &{success_card}[card_name]  &{success_card}[card_issuedate]
    Func_PaymentMethod.Get Detail Notification  &{ConnectBank}[VerifyCard_Number]

Link Via Bank Card - First Time Success
    [Tags]  Link_Bank_Card_Success_1
    Func_Login.Unlock To Access App Payoo
    Func_LinkAccount.Select Link Account
    Func_LinkAccount.Add Link Card SCB              &{scb_card_work}[card_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Fill OTP And Complete Linking Bank  SUNSET
    Func_LinkAccount.Verify Link Bank Card   SCB    &{scb_card_work}[card_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Delete Link Bank Account/Card

Link Via Bank Account - First Time Success
    [Tags]  Link_Bank_Account_Success_1
    Func_Login.Unlock To Access App Payoo
    Func_LinkAccount.Select Link Account
    Func_LinkAccount.Add Link Account SCB               &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Fill OTP And Complete Linking Bank  SUNSET
    Func_LinkAccount.Verify Link Bank Account   SCB     &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Delete Link Bank Account/Card

Link Via Bank Account - ReLink With Exist Account Success
    [Tags]  Link_Bank_Account_Success_2
    Func_Login.Unlock To Access App Payoo
    Func_LinkAccount.Select Link Account
    Func_LinkAccount.Add Link Account SCB               &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Fill OTP And Complete Linking Bank  SUNSET
    Func_LinkAccount.Verify Link Bank Account   SCB     &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Delete Link Bank Account/Card
    Func_LinkAccount.Add Link Account SCB               &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Fill OTP And Complete Linking Bank  SUNSET
    Func_LinkAccount.Verify Link Bank Account   SCB     &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]
    Func_LinkAccount.Delete Link Bank Account/Card

Link Via Bank Account - Link To Account Which Have Linking To Another E-Wallet
    [Documentation]  Liên kết với tài khoản đã được liên kết với 1 ví khác
    [Tags]  Link_Bank_Account_Error_1
    # Link &{scb_card_work}[account_number_3] Voi VDT: quanpham_1

Link Via Bank Account - Invalid ID Card Is Register At Bank
    [Documentation]  Nhập sai số CMND được khai báo tại Bank  # Rule số CMND hợp lệ tại Payoo là 9/12 số
    [Tags]  Link_Bank_Account_Error_1
    Func_Login.Unlock To Access App Payoo
    Func_LinkAccount.Select Link Account
    Func_LinkAccount.Add Link Account SCB  &{scb_card_work}[account_number_3]   &{scb_card_work}[card_name_3]   &{scb_card_work}[id_card_3]

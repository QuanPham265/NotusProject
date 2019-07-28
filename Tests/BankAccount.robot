*** Settings ***
Library  Dialogs
Resource  ../Resources/common.robot
Resource  ../Resources/Func_Login.robot
Resource  ../Resources/Func_ManageBank_CardAccount.robot
Resource  ../DataSystem/PAYOO_MessagesList.robot

Test Setup          common.Begin Testing Android
Test Teardown       common.End Testing

*** Variables ***
&{data_kyc_hxm}  ewallet_name=qtest_kyc_5           full_name=QUAN PHAM     id_card=244875231   bank_card_dxn=9704034267569884
&{data_kyc_approved_ref}
...  ewallet_name=qc_automation_kyc_1               full_name=QUAN AUTO                         id_card=532345689  phone=0985525869
...  bank_link=9704032582582589                     bank_card_dxn=9704034616656419              bank_card_cxn_null=9704031545516719
...  bank_card_cxn_choduyet=9704035616645419        bank_card_cxn_hople=9704031545135419        bank_card_cxn_kodat=9704031555155719

&{data_test_diff}   full_name=QUAN ZSWE     id_card=456336669874

# How to run Script
# robot -d C:/results/MobileApp -i test tests/BankAccount.robot

*** Test Cases ***
KYC Hủy xác minh - Add Card - Giới hạn danh sách Bank khi thêm thẻ
    [Documentation]  AddCard_KYC_HXM_Bank_List
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Verify Limit Bank Card Allow Adding For eWallet Without Complete KYC

KYC Hủy xác minh - Add Card - Số thẻ mới hợp lệ
    [Documentation]  AddCard_KYC_HXM_Add_NewCardNo_Successful
    [Tags]  doing
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card  &{data_kyc_hxm}[full_name]  &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully - Keep Autofill ID Card And Name
#    Verify Bank Card Reliability

KYC Hủy xác minh - Add Card - Số thẻ mới hợp lệ với tên khác Profile
    [Documentation]  AddCard_KYC_HXM_Add_NewCardNo_Diff_FullName_Successful
    [Tags]  doing
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card  &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully                         &{data_test_diff}[full_name]   &{data_kyc_hxm}[id_card]
#    Verify Bank Card Reliability

KYC Hủy xác minh - Add Card - Số thẻ mới hợp lệ với CMND khác Profile
    [Documentation]  AddCard_KYC_HXM_Add_NewCardNo_Diff_IDCard_Successful
    [Tags]  doing
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card  &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully                         &{data_kyc_hxm}[full_name]     &{data_test_diff}[id_card]
#    Verify Bank Card Reliability

KYC Hủy xác minh - Add Card - Số thẻ mới hợp lệ với CMND được duyệt KYC tại ví khác
    [Documentation]  AddCard_KYC_HXM_Add_NewCardNo_With_Approved_IDCard
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card      &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add New Bank Card Sacombank With Error Happen After Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_approved_ref}[id_card]
    Func_ManageBank_CardAccount.Verify Error Notification  ${API_AddCardAccount_ExistID_Card_EN}

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo với trạng thái đã xác nhận của ví khác
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_approved_ref}[bank_card_dxn]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo với trạng thái đã xác nhận của chính ví đó
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_hxm}[bank_card_dxn]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo với trạng thái chưa xác nhận và Null
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_approved_ref}[bank_card_dxn]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo với trạng thái chưa xác nhận và chờ duyệt
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_approved_ref}[bank_card_cxn_choduyet]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo với trạng thái chưa xác nhận và không đạt
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_approved_ref}[bank_card_cxn_kodat]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo với trạng thái chưa xác nhận và hợp lệ
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_approved_ref}[bank_card_cxn_hople]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong hệ thống Payoo đang liên kết với ví khác
    [Documentation]  AddCard_KYC_HXM_Add_Exist_Card
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Add Bank Card  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Card         &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Exist Bank Card Sacombank With Error Happen Before Input OTP    &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]  &{data_kyc_approved_ref}[bank_link]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Card - Số thẻ đã tồn tại trong chính ví đó
    [Documentation]  AddCard_KYC_HXM_Add_New_Double_Times
    [Tags]  doing  # con thieu thong bao loi, ma loi
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Add Bank Card Sacombank Double Times  &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Verify Error Notification

KYC Hủy xác minh - Add Link Bank - Liên kết thành công với số thẻ mới
    [Documentation]  LinkBank_KYC_HXM_Add_NewCardNo_Successful
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Link Account
    Func_ManageBank_CardAccount.Select Link Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Bank Link  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Link  &{data_kyc_hxm}[full_name]  &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Link Bank Card Sacombank Successfully - Keep Autofill ID Card And Name
    Func_ManageBank_CardAccount.Clean up Link Bank Card Added Before

KYC Hủy xác minh - Add Link Bank - Liên kết thành công với số thẻ mới hợp lệ với tên khác Profile
    [Documentation]  LinkBank_KYC_HXM_Add_NewCardNo_Diff_FullName_Successful
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Link Account
    Func_ManageBank_CardAccount.Select Link Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Bank Link  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Link  &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Link Bank Card Sacombank Successfully                                &{data_test_diff}[full_name]   &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Clean up Link Bank Card Added Before

KYC Hủy xác minh - Add Link Bank - Liên kết thành công với số thẻ mới hợp lệ với CMND khác Profile
    [Documentation]  AddCard_KYC_HXM_Add_NewCardNo_Diff_IDCard_Successful
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Link Account
    Func_ManageBank_CardAccount.Select Link Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Bank Link  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Link  &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add Link Bank Card Sacombank Successfully                                &{data_kyc_hxm}[full_name]     &{data_test_diff}[id_card]
    Func_ManageBank_CardAccount.Clean up Link Bank Card Added Before

KYC Hủy xác minh - Add Link Bank - Liên kết với số CMND được KYC trong ví khác
    [Documentation]  LinkBank_KYC_HXM_Add_Exist_Link
    [Tags]  test232
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Link Account
    Func_ManageBank_CardAccount.Select Link Bank Card Sacombank - Show Only Bank Support KYC
    Func_ManageBank_CardAccount.Verify Enable Editing Fields Identity Card And eWallet's Username - Bank Link  true  true
    Func_ManageBank_CardAccount.Verify Autofill Fields Identity Card And eWallet's Username - Bank Link  &{data_kyc_hxm}[full_name]     &{data_kyc_hxm}[id_card]
    Func_ManageBank_CardAccount.Add New Link Bank Card Sacombank With Error Happen Before Input OTP      &{data_kyc_hxm}[full_name]     &{data_kyc_approved_ref}[id_card]
    Func_ManageBank_CardAccount.Verify Error Notification

Test SQL
    [Tags]  sql
    Func_ManageBank_CardAccount.Test SQL

KYC Hủy xác minh - Edit Card - Check cho phép edit thông tin với thẻ chưa xác nhận và chờ duyệt
    [Documentation]  EditCard_KYC_HXM_VerifyEditing_CXN_Choduyet
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    ${card_no_stb} =  Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully        &{data_kyc_hxm}[full_name]   &{data_kyc_hxm}[id_card]
    
    Func_ManageBank_CardAccount.Select Edit Bank Card Sacombank
    Func_ManageBank_CardAccount.Verify Enable Editing Field - Edit Bank Card Sacombank   true  true
    Func_ManageBank_CardAccount.Back To Screen Card Account Management From Edit Card
    Func_ManageBank_CardAccount.Clean up Bank Card Added Before

KYC Hủy xác minh - Edit Card - Check cho phép edit thông tin với thẻ chưa xác nhận và trạng thái duyệt không đạt
    [Documentation]  EditCard_KYC_HXM_VerifyEditing_CXN_khongdat
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    ${card_no_stb} =  Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully        &{data_kyc_hxm}[full_name]   &{data_kyc_hxm}[id_card]

    Func_ManageBank_CardAccount.Change Value BankAccountReliability Of Bank Card By Script SQL      &{data_kyc_hxm}[ewallet_name]  ${card_no_stb}  khongdat
    Func_ManageBank_CardAccount.Select Edit Bank Card Sacombank
    Func_ManageBank_CardAccount.Verify Enable Editing Field - Edit Bank Card Sacombank   true  true
    Func_ManageBank_CardAccount.Back To Screen Card Account Management From Edit Card
    Func_ManageBank_CardAccount.Clean up Bank Card Added Before

KYC Hủy xác minh - Edit Card - Check cho phép edit thông tin với thẻ chưa xác nhận và trạng thái duyệt null
    [Documentation]  EditCard_KYC_HXM_VerifyEditing_CXN_null
    [Tags]  done
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    ${card_no_stb} =  Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully        &{data_kyc_hxm}[full_name]   &{data_kyc_hxm}[id_card]

    Func_ManageBank_CardAccount.Change Value BankAccountReliability Of Bank Card By Script SQL      &{data_kyc_hxm}[ewallet_name]  ${card_no_stb}  null
    Func_ManageBank_CardAccount.Select Edit Bank Card Sacombank
    Func_ManageBank_CardAccount.Verify Enable Editing Field - Edit Bank Card Sacombank   true  true
    Func_ManageBank_CardAccount.Back To Screen Card Account Management From Edit Card
    Func_ManageBank_CardAccount.Clean up Bank Card Added Before

KYC Hủy xác minh - Edit Card - Check cho phép edit thông tin với thẻ chưa xác nhận và trạng thái duyệt hợp lệ
    [Documentation]  EditCard_KYC_HXM_VerifyEditing_CXN_hople
    [Tags]  test
    Func_Login.Unlock To Access App Payoo
    Func_ManageBank_CardAccount.Access Screen Manage Bank Card
    Func_ManageBank_CardAccount.Select Add Bank Card Sacombank - Show Only Bank Support KYC
    ${card_no_stb} =  Func_ManageBank_CardAccount.Add Bank Card Sacombank Successfully        &{data_kyc_hxm}[full_name]   &{data_kyc_hxm}[id_card]

    Func_ManageBank_CardAccount.Change Value BankAccountReliability Of Bank Card By Script SQL      &{data_kyc_hxm}[ewallet_name]  ${card_no_stb}  hople
    Func_ManageBank_CardAccount.Select Edit Bank Card Sacombank
    pause execution
    Func_ManageBank_CardAccount.Verify Enable Editing Field - Edit Bank Card Sacombank   true  true
    Func_ManageBank_CardAccount.Back To Screen Card Account Management From Edit Card
    Func_ManageBank_CardAccount.Clean up Bank Card Added Before
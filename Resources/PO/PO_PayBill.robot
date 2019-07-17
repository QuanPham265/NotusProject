*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
## Screen SEARCH BILL
${ID_Select_Service}           xpath=//*[contains(@text,'Service')]
# Top Service
${ID_Serv_Electricity}         xpath=//*[contains(@text,'Electricity')]
${ID_Serv_Water}               xpath=//*[contains(@text,'Water')]
${ID_Serv_Telephone}           xpath=//*[contains(@text,'Telephone')]
${ID_Serv_Mobi_phone}          xpath=//*[contains(@text,'Mobi phone')]
${ID_Serv_Television}          xpath=//*[contains(@text,'Television')]

&{ALL_Service}                          Electricity=${ID_Serv_Electricity}      Water=${ID_Serv_Water}      Telephone=${ID_Serv_Telephone}
...  Mobi_phone=${ID_Serv_Mobi_phone}   Television=${ID_Serv_Television}

# Biller
${ID_Telephone_VNPT}           xpath=/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.RelativeLayout[1]/android.widget.TextView  #xpath=//*[contains(@text,'VNPT')]
${ID_Television_SCTVHCM}       xpath=//*[contains(@text,'SCTV Hồ Chí Minh')]
&{Biller_Telephone}            VNPT=${ID_Telephone_VNPT}
&{Biller_Television}           SCTVHCM=${ID_Television_SCTVHCM}

&{Biller_ALL}                  Telephone=&{Biller_Telephone}       Television=&{Biller_Television}

${ID_TextBox_BillCode}         id=vn.payoo.sandbox.debug:id/txtKCustomerCode

## Screen BILL INFORMATION
${ID_Bill_Infor_Service}
${ID_Bill_Infor_Biller}
${ID_Bill_Infor_Customer_Name}
${ID_Bill_Infor_Code}

${ID_Select_Period}                     id=vn.payoo.sandbox.debug:id/cbCheckAll
${ID_Fee_Bill}

## Screen PAYMENT METHOD
${ID_Payment_Method_LinkedAcc}          xpath=//*[contains(@text,'LINKED ACCOUNT')]
${ID_Payment_Method_Domestic}           xpath=//*[contains(@text,'DOMESTIC CARD')]
${ID_Payment_Method_International}      xpath=//*[contains(@text,'INTERNATIONAL CARD')]
${ID_Payment_Method_EWallet}            xpath=//*[contains(@text,'PAYOO E-WALLET')]

## Screen Account Information
#vn.payoo.sandbox.debug:id/tvWallet
#vn.payoo.sandbox.debug:id/tvWalletFullName
#vn.payoo.sandbox.debug:id/tvWalletEmail

## Screen PAYMENT CONFIRMATION
#vn.payoo.sandbox.debug:id/tvPayment
#vn.payoo.sandbox.debug:id/tvFee
#vn.payoo.sandbox.debug:id/tvTotal
${ID_Agreement}                 id=vn.payoo.sandbox.debug:id/cbConfirm
${ID_OTP}                       id=vn.payoo.sandbox.debug:id/etKOTP
${ID_OTP_BtnOK}                 xpath=//*[contains(@text,'OK')]
${ID_Title_Notification}        id=vn.payoo.sandbox.debug:id/md_title
${ID_Content_Notification}	    id=vn.payoo.sandbox.debug:id/md_content

## Screen Payment Successfully
#Payment successfully
#vn.payoo.sandbox.debug:id/lblTitleSuccess
${ID_Btn_BackToHome}            id=vn.payoo.sandbox.debug:id/btnBackToHome
${ID_Btn_Continue}              xpath=//*[contains(@text,'CONTINUE')]

*** Keywords ***
Select Service
    [Arguments]  ${service}
    wait until element is visible  ${ID_Select_Service}  timeout=60s
    click element  ${ID_Select_Service}
    ${id_service_paybill} =  set variable  &{ALL_Service}[${service}]
    wait until element is visible  ${id_service_paybill}  timeout=60s
    click element  ${id_service_paybill}

Select Biller
    [Arguments]  ${service}  ${biller}
    ${dict_all_service} =  create dictionary  &{Biller_ALL}
    log dictionary  ${dict_all_service}
    ${dict_all_biller} =   set variable  &{dict_all_service}[${service}]
    log dictionary  ${dict_all_biller}
    ${id_biller} =         set variable  &{dict_all_biller}[${biller}]
    wait until element is visible  ${id_biller}  timeout=60s
    click element  ${id_biller}

Select City - Telephone - VNPT
    [Arguments]  ${city}=Bắc Kạn
    wait until page contains element  xpath=//*[contains(@text,'Bắc Kạn')]  timeout=60s
    click element  xpath=//*[contains(@text,'Bắc Kạn')]

Input CustomerCode
    sleep  2s
    ${bill_code} =  Generate Random Bill
    input text   ${ID_TextBox_BillCode}  ${bill_code}

Select Period To Pay
	wait until page contains element  ${ID_Select_Period}  timeout=60s
	click element  ${ID_Select_Period}
	sleep  2s

Select Payment Method
    [Arguments]  ${payment_method}
    wait until page contains element  ${ID_Payment_Method_EWallet}  timeout=20s
    run keyword if  '${payment_method}' == 'LINKED'             click element   ${ID_Payment_Method_LinkedAcc}
    ...    ELSE IF  '${payment_method}' == 'DOMESTIC'           click element   ${ID_Payment_Method_Domestic}
    ...    ELSE IF  '${payment_method}' == 'INTERNATIONAL'      click element   ${ID_Payment_Method_International}
    ...    ELSE IF  '${payment_method}' == 'EWALLET'            click element   ${ID_Payment_Method_EWallet}

Accept Payment Policy
    wait until page contains element  ${ID_Agreement}  timeout=60s
    click element  ${ID_Agreement}

Click Button Continue
    click element    ${ID_Btn_Continue}

Click Button PAY
    click element    id=vn.payoo.sandbox.debug:id/btnNext

Generate Random Bill
    ${order_bill} =  generate random string  4  [NUMBERS]
    [Return]  ${order_bill}

Enter OTP Sent From Bank
    [Arguments]  ${otp_bank}
    input text  ${ID_OTP}  ${otp_bank}
    sleep  0.5s
    click element  ${ID_OTP_BtnOK}

Payment confirmation - Exist Notification
    ${bln_notification} =  run keyword and return status  wait until element is visible  ${ID_Title_Notification}  timeout=15s
    [Return]  ${bln_notification}

Payment confirmation - Exist OTP
    ${bln_otp} =  run keyword and return status  wait until element is visible  ${ID_OTP}  timeout=8s
    [Return]  ${bln_otp}

Payment confirmation - Get Title Notification
    ${title} =  get text    ${ID_Title_Notification}
    [Return]  ${title}

Payment confirmation - Get Content Notification
    ${content} =  get text    ${ID_Content_Notification}
    [Return]  ${content}
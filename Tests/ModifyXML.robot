*** Settings ***
Library  XML
Library  String
Library  xmlformatter
Resource  ../Libraries/ModXml.robot
Resource  ../Resources/XML/PayBill_Infor_Provider.robot

*** Variables ***
# Android Setting
${XML_Android_Setting} =     D:/Work/Automation Tools/explore-libraries/Inputs/XML/AndroidSetting.Config
${XML_Android_Setting_BK} =  D:/Work/Automation Tools/explore-libraries/Inputs/XML/AndroidSetting-BK.Config

# PATH of PayBill Services: DIEN, NUOC
${PATH_Paybill}                 PayBill/Services
${PATH_Biller}                  PayBill/Services/Service[@ORDER]/Providers
@{lst_paybill_service_vn}       DIEN            NUOC        DTCDCD          DTDDTQ          CAP         NET         TTTG
...                             TMDT            VEXE        THETINDUNG      HOCPHI          BAOHIEM     VIENPHI     DICHVUCONGCONG

@{lst_paybill_service}          ELECTRICITY     WATER       TELEPHONE       MOBILEPHONE     TELEVISION  INTERNET    INSTALLMENT
...                             ECOMERCE        TICKET      CREDITCARD      TUITION         SERVICE     INSURANCE   HOSPITAL

${dest}            D:/Dev/Projects/Payoo/5.Test/ScriptAuto/AndroidApp/DataSystem/XML/menu_temp.xml


# robot -d C:/results/ModifyXML tests/ModifyXML.robot
*** Test Cases ***
Add New Tag To Service NUOC
    ModXml.Add New Biller For Service PayBill  ${XML_Android_Setting}  ${PATH_Paybill}  ${PATH_Biller}  NUOC  ${dest}
    ...  reminder=true                      providerid=NUOCQUANPHAM             providername=NUOC QUANPHAM
    ...  logourl=logo_dienevnhn.jpg         samplebillurl=sample_nuoc.jpg       customercodetitle=MA ID|CODE



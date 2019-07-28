*** Settings ***
Library  AppiumLibrary

*** Variables ***
# Screen Select Bank: Domestic Card And International Card
${Nb_List_DomesticCard}         xpath=//*[@resource-id='vn.payoo.sandbox.debug:id/rcvInternalBanks']//android.widget.RelativeLayout
${Nb_List_InternationalCard}    xpath=//*[@resource-id='vn.payoo.sandbox.debug:id/rcvInternationalBanks']/android.widget.LinearLayout
${ID_AddCard_Full_Sacombank}            xpath=(//android.widget.ImageView[@content-desc="Payoo SandDebug"])[6]
${ID_AddCard_Full_ABBank}               xpath=(//android.widget.ImageView[@content-desc="Payoo SandDebug"])[17]
${ID_AddCard_Limit_Sacombank}           xpath=(//android.widget.ImageView[@content-desc="Payoo SandDebug"])[3]
${ID_AddCard_Limit_ABBank}              xpath=(//android.widget.ImageView[@content-desc="Payoo SandDebug"])[6]
${ID_LinkBank_Limit_Sacombank}          xpath=(//android.widget.ImageView[@content-desc="Payoo SandDebug"])[2]
${ID_AddAccount_Limit_Agribank}         xpath=(//android.widget.ImageView[@content-desc="Payoo SandDebug"])[1]

*** Keywords ***
Choose Add Card Sacombank - Display Full Bank
    click element  ${ID_AddCard_Full_Sacombank}

Choose Add Card Sacombank - Display Limit Bank
    click element  ${ID_AddCard_Limit_Sacombank}

Choose Link Bank Sacombank - Display Limit Bank
    click element  ${ID_LinkBank_Limit_Sacombank}

Get Number Displayed Domestic Card
    @{display_domestic_cards} =  get webelements  ${Nb_List_DomesticCard}
    ${nb_display_domestic_card} =  get length  ${display_domestic_cards}
    ${nb_display_domestic_card} =  convert to integer  ${nb_display_domestic_card}
    [Return]  ${nb_display_domestic_card}

Get Number Displayed International Card
    ${nb_display_international_card} =  get matching xpath count  ${Nb_List_InternationalCard}
    [Return]  ${nb_display_international_card}

Verify Screen Select Bank Loaded
    wait until page contains  Select bank  timeout=5s
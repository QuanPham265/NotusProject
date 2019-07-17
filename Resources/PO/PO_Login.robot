*** Settings ***
Library  AppiumLibrary

*** Variables ***
${ID_Cancel_Unlock_FingerPrint}     id=vn.payoo.sandbox.debug:id/cancel_button

${ID_Btn_Login}                     id=vn.payoo.sandbox.debug:id/btnLogin
${ID_TxtBox_eWalet}                 id=vn.payoo.sandbox.debug:id/etKWallet
${ID_TxtBox_Password}               id=vn.payoo.sandbox.debug:id/etKPassword

*** Keywords ***
Cancel PopUp Unlock By FingerPrint
    # click close to enter passcode
    wait until element is visible  ${ID_Cancel_Unlock_FingerPrint}  timeout=10s
    click element  ${ID_Cancel_Unlock_FingerPrint}

Input Passcode To Unlock
    # enter passcode to access app
    wait until element is visible  id=vn.payoo.sandbox.debug:id/btn8  timeout=5s
    click element  id=vn.payoo.sandbox.debug:id/btn8
    click element  id=vn.payoo.sandbox.debug:id/btn8
    click element  id=vn.payoo.sandbox.debug:id/btn8
    click element  id=vn.payoo.sandbox.debug:id/btn8

Input eWallet
    [Arguments]  ${username}
    input text   ${ID_TxtBox_eWalet}  ${username}

Input Password
    [Arguments]  ${password}
    input text   ${ID_TxtBox_Password}  ${password}

Click Button Login
#    wait until page contains element  ${ID_Btn_Login}  timeout=10s
#    click element  ${ID_Btn_Login}

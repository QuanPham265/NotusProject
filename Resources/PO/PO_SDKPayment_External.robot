*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
${SDK_External_eWallet_Username}            xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[5]/android.view.View/android.view.View[4]/android.view.View/android.view.View[2]/android.widget.EditText
${SDK_External_eWallet_Password}            xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[5]/android.view.View/android.view.View[4]/android.view.View/android.view.View[3]/android.widget.EditText
${SDK_External_eWallet_BtnLogin}            xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[5]/android.view.View/android.view.View[4]/android.view.View/android.view.View[4]/android.widget.Button
${SDK_External_eWallet_BtnPay}              xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View[4]/android.view.View[5]/android.widget.Button
${SDK_External_BtnContinue}                 xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[8]/android.view.View[2]/android.view.View[6]/android.view.View[4]/android.view.View[3]

${SDK_External_Domestic_CardNo}             xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[8]/android.view.View[2]/android.view.View[6]/android.view.View[1]/android.widget.EditText
${SDK_External_Domestic_CardName}           xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[8]/android.view.View[2]/android.view.View[6]/android.view.View[2]/android.widget.EditText
${SDK_External_Domestic_Phone}              xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[8]/android.view.View[2]/android.view.View[6]/android.view.View[3]/android.widget.EditText
${SDK_External_Domestic_Email}              xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[8]/android.view.View[2]/android.view.View[6]/android.view.View[4]/android.widget.EditText
${SDK_External_Domestic_OTP}                xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[6]/android.view.View[6]/android.view.View[7]/android.view.View/android.view.View[1]

${SDK_External_International_CardNo}        xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View/android.view.View[5]/android.view.View[1]/android.widget.EditText
${SDK_External_International_CardName}      xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View/android.view.View[5]/android.view.View[2]/android.widget.EditText
${SDK_External_International_ExpiryDate}    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View/android.view.View[5]/android.view.View[4]/android.view.View/android.widget.EditText
${SDK_External_International_CVC}           xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View/android.view.View[5]/android.view.View[5]/android.view.View/android.widget.EditText
${SDK_External_International_Phone}         xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View/android.view.View[5]/android.view.View[6]/android.widget.EditText
${SDK_External_International_Email}         xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View/android.view.View[5]/android.view.View[7]/android.widget.EditText
${SDK_External_International_BtnContinue}   xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[9]/android.view.View[2]/android.view.View[5]/android.view.View[8]/android.view.View[3]

# Confirmation
${SDK_External_Cfrm_Amount}              xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View[4]/android.view.View[4]/android.widget.ListView/android.view.View[4]/android.view.View[2]
${SDK_External_Cfrm_OrderNo}             xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View[4]/android.view.View[4]/android.widget.ListView/android.view.View[1]/android.view.View[2]
${SDK_External_Cfrm_eWallet}             xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View[4]/android.view.View[3]/android.widget.ListView/android.view.View[1]/android.view.View[2]


*** Keywords ***
# Web Browser Loaded
Verify Payment Method eWallet Loaded
    wait until page contains  VÍ ĐIỆN TỬ PAYOO  timeout=60s

Verify Payment Method Domestic Loaded
    wait until page contains  THÔNG TIN THANH TOÁN  timeout=60s

Verify Payment Method International Loaded
    wait until page contains  THÔNG TIN THANH TOÁN  timeout=60s

Fill eWallet Username
    [Arguments]  ${username}
    input text  ${SDK_External_eWallet_Username}  ${username}

Fill eWallet Password
    [Arguments]  ${password}
    input text  ${SDK_External_eWallet_Password}  ${password}

# Method Domestic Card
Domestic Card - Fill CardNo
    [Arguments]  ${card_no}
    input text  ${SDK_External_Domestic_CardNo}  ${card_no}

Domestic Card - Fill CardName
    [Arguments]  ${card_name}
    input text  ${SDK_External_Domestic_CardName}  ${card_name}

Domestic Card - Fill Phone
    [Arguments]  ${phone}
    input text  ${SDK_External_Domestic_Phone}  ${phone}

Domestic Card - Fill Email
    [Arguments]  ${email}
    input text  ${SDK_External_Domestic_Email}  ${email}

Click Button Login
    click element  ${SDK_External_eWallet_BtnLogin}

Click Button PAY
    wait until element is visible  ${SDK_External_eWallet_BtnPay}  timeout=30s
    click element    ${SDK_External_eWallet_BtnPay}

Click Button Continue
    click element  ${SDK_External_BtnContinue}

Fill OTP
    wait until element is visible  ${SDK_External_Domestic_OTP}  timeout=10s
    pause execution
    scroll up    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[2]/android.view.View[6]/android.view.View[6]/android.view.View[2]
    pause execution
    input text  ${SDK_External_Domestic_OTP}  123456

# Method International Card
International Card - Scroll Down
    scroll  ${SDK_External_International_ExpiryDate}  ${SDK_External_International_CardName}

International Card - CardNo
    [Arguments]  ${card_no}
    input text  ${SDK_External_International_CardNo}  ${card_no}

International Card - CardName
    [Arguments]  ${card_name}
    input text  ${SDK_External_International_CardName}  ${card_name}

International Card - Phone
    [Arguments]  ${phone}
    wait until element is visible  ${SDK_External_International_Phone}  timeout=10s
    input text  ${SDK_External_International_Phone}  ${phone}

International Card - Email
    [Arguments]  ${email}
    wait until element is visible  ${SDK_External_International_Email}  timeout=10s
    input text  ${SDK_External_International_Email}  ${email}

International Card - Expiry Date
    [Arguments]  ${expiry_date}
    input text  ${SDK_External_International_ExpiryDate}  ${expiry_date}

International Card - CVC
    [Arguments]  ${cvc}
    input text  ${SDK_External_International_CVC}  ${cvc}

International Card - Click Button Continue
    wait until element is visible  ${SDK_External_International_BtnContinue}  timeout=10s
    click element  ${SDK_External_International_BtnContinue}
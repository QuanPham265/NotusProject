*** Settings ***
Library  Dialogs
Resource  ./Resources/Sendo/PO_Sendo.robot

*** Variables ***
${BROWSER}          chrome
${Sendo_HomePage}   https://www.sendo.vn
${Username}         phamminhquan.ste@gmail.com
${Password}         PayooQuan265
${url_deal}         https://www.sendo.vn/non-rong-vanh-in-hinh-ngoi-sao-vang-14188282.html
${expect_price}     45000
${wait_time}        23:00:00


*** Keywords ***
Begin Web Test
    open browser  about:blank  ${BROWSER}
    maximize browser window

End Web Test
    close all browsers

# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF deal_sendo.robot
*** Test Cases ***
Get 1k Deal On Website Sendo
    [Teardown]  End Web Test
    Begin Web Test
    PO_Sendo.Access Web Sendo  ${Sendo_HomePage}
    PO_Sendo.Close Ads
    PO_Sendo.Verify HomePage Loaded
    PO_Sendo.Click Button SignIn
    PO_Sendo.Sign In Exist Account
    PO_Sendo.Input UserName And Password  ${Username}  ${Password}
    PO_Sendo.Access Web Product  ${url_deal}
    PO_Sendo.Click Button Buy NOW
    PO_Sendo.Get Time And Waiting  ${wait_time}
    PO_Sendo.Get Current Price And Compare With Expect Price  ${expect_price}

*** Settings ***
Library  SeleniumLibrary
Library  Dialogs
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/String.py
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/DateTime.py

*** Variables ***
${Ele_SignIn}               xpath://span[contains(text(),'Đăng nhập')]
${ELe_Text_HavedAcc}        xpath://div[contains(text(),'Đã có SendoID')]
${Ele_InputName}            xpath://input[@name='email']
${Ele_InputPass}            xpath://input[@name='password']
${Ele_Btn_Login}            xpath://button[@class='btnLogin_1Dve']
${Ele_Campaign}             xpath://div[@class='Campaign__innerWrapper']
${Ele_Ads}                  xpath://button[@title='Close']
${Ele_BuyNow}               xpath://button[contains(text(),'Mua ngay')]
${Ele_Price}                xpath://span[contains(text(),'Tổng tiền hàng')]/parent::*/span[2]

*** Keywords ***
Access Web Sendo
    [Arguments]  ${url}
    go to  ${url}

Close Ads
    ${status} =  run keyword and return status  wait until page contains element  ${Ele_Campaign}  timeout=30s
    run keyword if  ${status}  capture page screenshot
    run keyword if  ${status}  click element  ${Ele_Ads}
    run keyword if  ${status}  sleep  1s

Verify HomePage Loaded
    wait until page contains  Đăng nhập  timeout=15s

Click Button SignIn
    click element  ${Ele_SignIn}
    sleep  2s

Sign In Exist Account
    wait until page contains element  ${ELe_Text_HavedAcc}  timeout=10s
    click element  ${ELe_Text_HavedAcc}

Input UserName And Password
    [Arguments]  ${username}  ${password}
    wait until element is visible  ${Ele_InputName}  timeout=10s
    input text  ${Ele_InputName}   ${username}
    input text  ${Ele_InputPass}   ${password}
    click element  ${Ele_Btn_Login}
    sleep  2s

Access Web Product
    [Arguments]  ${url}
    go to  ${url}

Click Button Buy NOW
    wait until page contains element    ${Ele_BuyNow}  timeout=10s
    click element                       ${Ele_BuyNow}
    wait until page contains element    ${Ele_Price}

Get Time And Waiting
    [Arguments]  ${time}
    ${curt} =  get current date  result_format=%H:%M:%S
    ${sub_time} =  subtract time from time  ${time}  ${curt}
    log to console  ${\n}TIME NOW: ${curt}
    log to console  ${\n}HAVE TO WAIT ${sub_time} SECONDS
    sleep  ${sub_time}

Get Current Price And Compare With Expect Price
    [Arguments]  ${expect_price}
    :FOR  ${index}  IN RANGE  9000
    \   wait until page contains element    ${Ele_Price}
    \   ${current_price} =  get text        ${Ele_Price}
    \   ${current_price} =  remove string   ${current_price}  .
    \   ${current_price} =  remove string   ${current_price}  đ
    \   ${status} =  run keyword and return status  should be equal as numbers  ${current_price}  ${expect_price}
    \   log to console  ${\n} CURREN PRICE: ${current_price}, VALUE STATUS: ${status}
    \   run keyword unless  ${status}  reload page
    \   exit for loop if  ${status}
    click element  xpath://span[contains(text(),'Đặt hàng')]
    capture page screenshot
    pause execution


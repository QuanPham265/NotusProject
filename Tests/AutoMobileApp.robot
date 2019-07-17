*** Settings ***
Library  AppiumLibrary
Library  Dialogs

*** Variables ***
${appium_host} =        http://localhost:4723/wd/hub

# For iOS Device
${platform_name_ios} =      iOS
@{platformVersion_ios} =    11.4.1                                      12.1
@{deviceName_ios} =         Payoo                                       Notus iPhone
@{udid_ios} =               fab3cb6be7fbc0d22741b1ac0ff71462c5235e0e    327df49a8be8ed02a67fb6f26ff308228389f7b0
${automationName_ios} =     XCUITest
${bundleID_safari} =        com.apple.mobilesafari
${bundleID_sandbox} =       vn.payoo.Payoo.sandbox

# Android Setting
${platform_name_andr} =     android
@{platformVersion_andr} =   8.0            12.1
@{deviceName_andr} =        Quan           Notus
${appPackage} =             vn.payoo.sandbox.debug
${appActivity} =            vn.payoo.main.activity.WelcomeActivity
${automationName_andr} =    uiautomator2
${app} =                    C:\\Users\\quan.pham\\Desktop\\payoo-sandbox-debug.apk
${noreset_andr} =           true

# robot -i android -d C:/results/Mobile tests/automobileapp.robot
*** Test Cases ***
Test App iOS
    [Tags]  ios
     Open Application    ${appium_host}    platformName=${platform_name_ios}        platformVersion=@{platformVersion_ios}[1]
     ...  deviceName=@{deviceName_ios}[1]           udid=@{udid_ios}[1]
     ...  automationName=${automationName_ios}      bundleId=${bundleID_safari}

Test App Android
    [Tags]  Android
     Open Application    remote_url=${appium_host}          automationName=${automationName_andr}
    ...  platformName=${platform_name_andr}                 appPackage=${appPackage}
    ...  platformVersion=@{platformVersion_andr}[0]         appActivity=${appActivity}
    ...  deviceName=@{deviceName_andr}[0]                   noReset=${noreset_andr}
#    ...  app=${app}
    # click close to enter passcode
    wait until element is visible  id=vn.payoo.sandbox.debug:id/cancel_button  timeout=5s
    click element  id=vn.payoo.sandbox.debug:id/cancel_button
    # enter passcode to access app
    wait until element is visible  id=vn.payoo.sandbox.debug:id/btn8  timeout=5s
    click element  id=vn.payoo.sandbox.debug:id/btn8
    click element  id=vn.payoo.sandbox.debug:id/btn8
    click element  id=vn.payoo.sandbox.debug:id/btn8
    click element  id=vn.payoo.sandbox.debug:id/btn8
    # Choose service Pay Bill
    wait until element is visible  id=xpath=//android.widget.TextView[@text='BILL PAYMENT']  timeout=120s
    click element  id=xpath=//android.widget.TextView[@text='BILL PAYMENT']
#    wait until element is visible  xpath://android.widget.TextView[@text='BILL PAYMENT']  timeout=45s
    pause execution
    # croll up  xpath=//*[contains(@text,'BILL PAYMENT')]
    click element  xpath=//android.widget.TextView[@text='BILL PAYMENT']
    # Choose One Service
    Click Element    xpath=/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout
    click element  xpath:/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.RelativeLayout[6]


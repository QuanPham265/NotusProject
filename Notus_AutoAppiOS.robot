*** Settings ***
Library  AppiumLibrary

*** Variables ***
${appium_host} =        http://0.0.0.0:4723/wd/hub

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
${app} =                    /Users/macbook/Desktop/payoo-sandbox-debug.apk
${noreset_andr} =           true

# robot -i android notus_autoappios.robot
*** Test Cases ***
Test App iOS
    [Tags]  ios
     Open Application    ${appium_host}    platformName=${platform_name_ios}        platformVersion=@{platformVersion_ios}[1]
     ...  deviceName=@{deviceName_ios}[1]           udid=@{udid_ios}[1]
     ...  automationName=${automationName_ios}      bundleId=${bundleID_safari}

Test App Android
    [Tags]  Android
     Open Application    ${appium_host}    platformName=${platform_name_andr}       platformVersion=@{platformVersion_andr}[0]
     ...  deviceName=@{deviceName_andr}[0]            noReset=${noreset_andr}       appPackage=${appPackage}   appActivity=${appActivity}
     ...  automationName=${automationName_andr}       #app=${app}

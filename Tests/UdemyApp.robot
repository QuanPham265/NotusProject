*** Settings ***
Library  Dialogs
Library  AppiumLibrary
Resource  ../Resources/common.robot

#Test Setup          common.Start App Testing Demos
#Test Teardown       common.End Testing

*** Variables ***


# How to run Script
# robot -d C:/results/MobileApp -i test tests/UdemyApp.robot

*** Test Cases ***
Test APP demos
    [Tags]  test
    common.Start App Testing Demos
    wait until element is visible  xpath=//android.widget.TextView[@text='Preference']  timeout=5s
    click element  xpath=//android.widget.TextView[@text='Preference']
    wait until element is visible  xpath=//android.widget.TextView[@text='3. Preference dependencies']  timeout=5s
    click element  xpath=//android.widget.TextView[@text='3. Preference dependencies']
    wait until element is visible  id=android:id/checkbox  timeout=5s
    click element  android:id/checkbox

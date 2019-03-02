*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${ID_Username}   name:username
${ID_Password}   name:password

*** Keywords ***
Begin Web Test
    open browser  about:blank   ff  ff_profile_dir=/Users/notuspham/Library/Application Support/Firefox/Profiles/qi66dkyd.Testing

End Web Test
    close all browsers

Go To Main Page Instagram
    [Arguments]  ${url}
    go to  ${url}
    sleep  2s

Main Page Loaded
    wait until page contains element  xpath://p[contains(text(),'Get the app.')]

Go To Page Log In
    [Arguments]  ${url}
    go to  ${url}
    sleep  2s

Insert Username
    [Arguments]  ${username}
    input text  ${ID_Username}  ${username}

Insert Password
    [Arguments]  ${password}
    input text  ${ID_Password}  ${password}

Click Button Submit
    click element  xpath://button[@type='submit']
    sleep  3s

Turn Off Notifications PopUp
    click element  xpath://button[contains(text(),'Not Now')]
    sleep  3s


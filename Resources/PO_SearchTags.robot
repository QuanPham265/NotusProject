*** Settings ***
Library  SeleniumLibrary
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/String.py
Library  Dialogs


*** Variables ***
${url_custom_tag} =  https://www.instagram.com/explore/tags/{search_tag}/?hl=en
${ID_MostRecent_Photo_SearchTag} =  xpath://h2[contains(text(),'Most recent')]/parent::*/div[2]/div/div[1]/div[1]
${ID_Like} =  xpath://span[@aria-label='Comment']/parent::*/parent::*/parent::*/span[1]/button/span[@aria-label='Like']

*** Keywords ***
Go To Page Show Photo With Tag
    [Arguments]  ${tag}
    ${url_tag} =  replace string  ${url_custom_tag}  {search_tag}  ${tag}
    go to  ${url_tag}

Click Most Recent Photo
    wait until element is visible  ${ID_MostRecent_Photo_SearchTag}  timeout=5s
    click element  ${ID_MostRecent_Photo_SearchTag}
    click element  ${ID_MostRecent_Photo_SearchTag}
    sleep  1s

Get Profile Name
    ${profile_name} =  get text  xpath://button[contains(text(),'Follow')]/parent::*/parent::*/div[1]/h2/a
    log  ${profile_name}
    [Return]  ${profile_name}

Interact LIKE
    wait until element is visible  xpath://span[@aria-label='Comment']  timeout=10s
    ${status} =  run keyword and return status  page should contain element   ${ID_Like}
    run keyword if  ${status}  click element  ${ID_Like}
    sleep  2s

Access Page Profile
    click element  xpath://button[contains(text(),'Follow')]/parent::*/parent::*/div[1]/h2/a  COMMAND
    sleep  2s
    capture page screenshot

Update Working Windows
    select window  MAIN
    sleep  1s

Click Button To Next Photo
    click element  xpath://a[contains(text(),'Next')]
    sleep  1.5s
    ${status} =  run keyword and return status  wait until element is visible  xpath://span[@aria-label='Comment']  timeout=15s
    run keyword unless  ${status}  click element  xpath://a[contains(text(),'Next')]
    sleep  1.5s

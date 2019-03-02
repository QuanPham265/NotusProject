*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/String.py
Resource  ./PO_MainPage.robot
Resource  ./PO_SearchTags.robot
Resource  ./PO_UserProfile.robot

*** Variables ***
${ID_Link_UserProfile} =   https://www.instagram.com/ProfileName/?hl=en

*** Keywords ***
Manually Login
    [Arguments]  ${url_mainpage}
    PO_MainPage.Go To Main Page Instagram   ${url_mainpage}
    pause execution

Log In
    [Arguments]  ${url_mainpage}  ${url_login}  ${username}  ${password}
    PO_MainPage.Go To Main Page Instagram   ${url_mainpage}
#    PO_MainPage.Main Page Loaded
#    PO_MainPage.Go To Page Log In           ${url_login}
#    PO_MainPage.Insert Username             ${username}
#    PO_MainPage.Insert Password             ${password}
#    PO_MainPage.Click Button Submit
#    PO_MainPage.Turn Off Notifications PopUp

Search Tags
    [Arguments]  ${tag}
    PO_SearchTags.Go To Page Show Photo With Tag  ${tag}
    sleep  3s

Like Sequentially With Number Account
    [Arguments]  ${number_wanted_acc_like}
    ${list_user_have_interact} =  create list
    PO_SearchTags.Click Most Recent Photo

    :FOR  ${index}  IN RANGE  ${number_wanted_acc_like}
    \   PO_SearchTags.Interact LIKE
    \   ${profile_name} =  PO_SearchTags.Get Profile Name
    \   log to console  ${index}: ${profile_name}
    \   append to list  ${list_user_have_interact}  ${profile_name}
    \   ${count} =  count values in list  ${list_user_have_interact}  ${profile_name}
    \   log  ${count}
    \   ${User_not_follow} =  run keyword and return status  element should be visible  xpath://button[contains(text(),'Follow')]/parent::*/parent::*/div[1]/h2/a
    \   run keyword if  ${count} == 1 and ${User_not_follow}    run keyword and ignore error  Go To Page Profile To Like Or Command
    \   PO_SearchTags.Update Working Windows
    \   PO_SearchTags.Click Button To Next Photo

Go To Page Profile To Like Or Command
    PO_SearchTags.Access Page Profile
    PO_UserProfile.Update Working Windows
    ${profile_name}  ${nb_posts}  ${nb_follower}  ${nb_following} =  PO_UserProfile.Get All Infor Of Profile
    run keyword if  ${nb_posts} > 10 and ${nb_follower} > 50 and ${nb_following} >50  Only Like Three Photo In Page Profile If Pass Condition
    PO_UserProfile.Close Profile Tab

Only Like Three Photo In Page Profile If Pass Condition
    PO_UserProfile.Open Most Recent Photo
    PO_UserProfile.Like Photo
    repeat keyword  2 times    PO_UserProfile.Move Next Photo In The Right
    PO_UserProfile.Like Photo
    repeat keyword  3 times    PO_UserProfile.Move Next Photo In The Right
    PO_UserProfile.Like Photo

Quick Move To Page Profile
    [Arguments]  ${profile_name}
    ${url_profile_name} =  replace string  ${ID_Link_UserProfile}  ProfileName  ${profile_name}
    log to console  ${url_profile_name}
    go to  ${url_profile_name}
    PO_UserProfile.Get The Number Of Following
    PO_UserProfile.Open Most Recent Photo






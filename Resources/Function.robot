*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  ExcelLibrary
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/String.py
Resource  ./Instagram/PO_MainPage.robot
Resource  ./Instagram/PO_SearchTags.robot
Resource  ./Instagram/PO_UserProfile.robot

*** Variables ***
${ID_Link_UserProfile}          https://www.instagram.com/ProfileName/?hl=en
${raw_excel_path}               /Users/notuspham/PycharmProjects/NotusProject/Resources/Excel_File/insta_profile_%KOL%.xlsx
${root_window}
${list_windows}

*** Keywords ***
Manually Login
    [Arguments]  ${url_mainpage}
    PO_MainPage.Go To Main Page Instagram   ${url_mainpage}
    pause execution

Navigate To Instagram Web
    [Arguments]  ${url_mainpage}
    PO_MainPage.Go To Main Page Instagram   ${url_mainpage}

Log In
    [Arguments]  ${url_login}  ${username}  ${password}
    PO_MainPage.Main Page Loaded
    PO_MainPage.Go To Page Log In           ${url_login}
    PO_MainPage.Insert Username             ${username}
    PO_MainPage.Insert Password             ${password}
    PO_MainPage.Click Button Submit
    PO_MainPage.Turn Off Notifications PopUp

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
    \   log to console  ${\n}${index}: ${profile_name}
    \   append to list  ${list_user_have_interact}  ${profile_name}
    \   ${count} =  count values in list  ${list_user_have_interact}  ${profile_name}
    #debug
    \   Get And Show Value Of Root Windows

    \   ${User_not_follow} =  run keyword and return status  element should be visible  xpath://button[contains(text(),'Follow')]/parent::*/parent::*/div[1]/h2/a
    \   run keyword if  ${count} == 1 and ${User_not_follow}    run keyword and ignore error  Go To Page Profile To Like Or Command
    \   Keep Only Root Windows Open
    \   PO_SearchTags.Click Button To Next Photo

Go To Page Profile To Like Or Command
    PO_SearchTags.Access Page Profile
    ${bln_nb_expc_window} =  PO_UserProfile.Update Working Windows  ${root_window}
    ${profile_name}  ${nb_posts}  ${nb_follower}  ${nb_following} =  run keyword if  ${bln_nb_expc_window}  PO_UserProfile.Get All Infor Of Profile
    run keyword if  ${bln_nb_expc_window} and ${nb_posts} > 10 and ${nb_follower} > 50 and ${nb_following} >50  Like Photos In Page Profile In Case OF Pass Condition

Like Photos In Page Profile In Case OF Pass Condition
    PO_UserProfile.Open And Like List Of Ordered Photo

Go Directly To User Profile
    [Arguments]  ${profile_name}
    ${url_profile_name} =  replace string  ${ID_Link_UserProfile}  ProfileName  ${profile_name}
    go to  ${url_profile_name}
    PO_UserProfile.Verify Page Specify User Profile Loaded  ${profile_name}
    ${account_isprivate} =  PO_UserProfile.Check Account IsPrivate
    run keyword if  ${account_isprivate}  log to console  ${\n}Skip This Private User Profile: ${profile_name}
    run keyword unless  ${account_isprivate}  Interacing Like In This Specify User Profile

Interacing Like In This Specify User Profile
    ${profile_name}  ${nb_posts}  ${nb_follower}  ${nb_following} =  PO_UserProfile.Get All Infor Of Profile
    run keyword if  ${nb_posts} > 10 and ${nb_follower} > 50 and ${nb_following} >50  Like Photos In Page Profile In Case OF Pass Condition

Get And Show Value Of Root Windows
    ${tmp} =  get window handles
    set suite variable  ${root_window}  @{tmp}[0]

Keep Only Root Windows Open
    ${list_windows} =  get window handles
    ${nb_tabs_open} =  get length  ${list_windows}
    remove values from list  ${list_windows}  ${root_window}
    :FOR  ${window}  IN  @{list_windows}
    \   select window  ${window}
    \   close window

    ${list_windows_final} =  get window handles
    ${nb_tabs_open_final} =  get length  ${list_windows_final}
    ${bln_nb_expc_window} =   run keyword and return status  should be equal as integers  ${nb_tabs_open}  1
    select window  ${root_window}

Read User Profile Name From File Excel
    [Arguments]  ${profile_kol}  ${row}  ${sheet}=user_like     #user_like,user_follow
    ${excel_path} =  replace string  ${raw_excel_path}  %KOL%  ${profile_kol}
    open excel document  ${excel_path}  doc_id=doc1
    ${user_profile_name} =  read excel cell  row_num=${row}  col_num=1  sheet_name=${sheet}
    close current excel document
    [Return]  ${user_profile_name}


*** Settings ***
Library  SeleniumLibrary
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/String.py
Library  Dialogs
Library  Collections

*** Variables ***
${ID_Name}              xpath://button[contains(text(),'Follow')]/parent::*/parent::*/parent::*/parent::*/div[1]/h1
${ID_Posts}             xpath://button[contains(text(),'Follow')]/parent::*/parent::*/parent::*/parent::*/ul/li[1]/span/span[1]
${ID_Follower}          xpath://button[contains(text(),'Follow')]/parent::*/parent::*/parent::*/parent::*/ul/li[2]/a/span
${ID_Following}         xpath://button[contains(text(),'Follow')]/parent::*/parent::*/parent::*/parent::*/ul/li[3]/a/span
${ID_Follower_Zero}     xpath://button[contains(text(),'Follow')]/parent::*/parent::*/parent::*/parent::*/ul/li[2]/span/span
${ID_Following_Zero}    xpath://button[contains(text(),'Follow')]/parent::*/parent::*/parent::*/parent::*/ul/li[3]/span/span

@{order_photo_like}         7  1  3  4  6
${ID_Exist_WS}              xpath://span[contains(text(),'Posts')]/parent::*/parent::*/parent::*/parent::*/div
${ID_Recent_Photo}          xpath://span[contains(text(),'Posts')]/parent::*/parent::*/parent::*/parent::*/div[2]/article/div[1]/div/div[%row%]/div[%order%]/a
${ID_Recent_Photo_WStory}   xpath://span[contains(text(),'Posts')]/parent::*/parent::*/parent::*/parent::*/div[3]/article/div[1]/div/div[%row%]/div[%order%]/a
${ID_Like}                  xpath://span[@aria-label='Comment']/parent::*/parent::*/parent::*/span[1]/button/span[@aria-label='Like']
${ID_Btn_Next}              xpath://a[contains(text(),'Next')]

*** Keywords ***
Update Working Windows
    [Arguments]  ${root_window}
    ${list_windows} =  get window handles
    ${nb_tabs_open} =  get length  ${list_windows}
    ${bln_nb_expc_window} =   run keyword and return status  should be equal as integers  ${nb_tabs_open}  2
    run keyword if  ${bln_nb_expc_window}  remove values from list  ${list_windows}  ${root_window}
    select window  @{list_windows}[0]
    [Return]  ${bln_nb_expc_window}

Get User Profile Name
    wait until element is visible  ${ID_Name}  timeout=10s
    ${profile_name} =  get text  ${ID_Name}
    log  ${profile_name}
    [Return]  ${profile_name}

Get The Number Of Post
    ${nb_posts} =  get text  ${ID_Posts}
    log  ${nb_posts}
    [Return]  ${nb_posts}

Get The Number Of Follower
    ${nb_follower} =  get text  ${ID_Follower}
    log  ${nb_follower}
    [Return]  ${nb_follower}

Get The Number Of Following
    ${status_Zero_Following} =     run keyword and return status  element should be visible  ${ID_Following_Zero}
    ${status_NonZero_Following} =  run keyword and return status  element should be visible  ${ID_Following}
    ${nb_following} =  run keyword if  ${status_NonZero_Following}  get text  ${ID_Following}
    ...                       ELSE IF  ${status_Zero_Following}     get text  ${ID_Following_Zero}
    log  ${nb_following}
    [Return]  ${nb_following}

Get All Infor Of Profile
    ${profile_name} =  Get User Profile Name
    ${nb_posts} =  Get The Number Of Post
    ${nb_follower} =  Get The Number Of Follower
    ${nb_following} =  Get The Number Of Following
    log many  ${profile_name}  ${nb_posts}  ${nb_follower}  ${nb_following}

    #Follwer
    ${boolean_zero_follower} =     run keyword and return status  evaluate            ${nb_follower} == 0
    ${boolean_more10k_follower} =  run keyword and return status  should contain any  ${nb_follower}  k
    ${boolean_less10k_follower} =  run keyword and return status  should contain any  ${nb_follower}  ,
    ${nb_follower_final} =  run keyword if  ${boolean_more10k_follower}   set variable   10000
    ...                            ELSE IF  ${boolean_less10k_follower}   remove string  ${nb_follower}  ,
    ...                            ELSE     set variable  ${nb_follower}
    ${nb_follower_final} =  convert to integer  ${nb_follower_final}

    #Follwing
    ${boolean_more10k_following} =  run keyword and return status  should contain any  ${nb_following}  k
    ${boolean_less10k_following} =  run keyword and return status  should contain any  ${nb_following}  ,
    ${nb_following_final} =  run keyword if  ${boolean_more10k_following}   set variable   10000
    ...                            ELSE IF   ${boolean_less10k_following}   remove string  ${nb_following}  ,
    ...                            ELSE      set variable  ${nb_following}
    ${nb_following_final} =  convert to integer  ${nb_following_final}

    #Postss
    ${boolean_zero_posts} =     run keyword and return status  evaluate            ${nb_posts} == 0
    ${boolean_more10k_posts} =  run keyword and return status  should contain any  ${nb_posts}  k
    ${boolean_less10k_posts} =  run keyword and return status  should contain any  ${nb_posts}  ,
    ${nb_posts_final} =  run keyword if   ${boolean_more10k_posts}   set variable   10000
    ...                         ELSE IF   ${boolean_less10k_posts}   remove string  ${nb_posts}  ,
    ...                         ELSE      set variable  ${nb_posts}
    ${nb_posts_final} =  convert to integer  ${nb_posts_final}
    [Return]  ${profile_name}  ${nb_posts_final}  ${nb_follower_final}  ${nb_following_final}

Open Most Recent Photo And Like
    ${count} =  get element count  ${ID_Exist_WS}
    ${id_photo_tmp} =   set variable if
    ...                 ${count} == 2        ${ID_Recent_Photo}
    ...                 ${count} == 3        ${ID_Recent_Photo_WStory}
    :FOR  ${order}  IN  @{order_photo_like}
    \   ${row}  ${order_new} =  Detect Row And Order Of Photos  ${order}
    \   ${id_photo} =  replace string  ${id_photo_tmp}  %order%  ${order_new}
    \   ${id_photo} =  replace string  ${id_photo}      %row%    ${row}
    \   ${url_photo} =  get element attribute  ${id_photo}  href
    \   go to  ${url_photo}
    \   sleep  1s
    \   Like Photo In Profile
    \   go back
    \   wait until element is visible  ${id_photo}  timeout=10s

Detect Row And Order Of Photos
    [Arguments]  ${order}
    ${row} =  set variable if
    ...  0 < ${order} <= 3      1
    ...  3 < ${order} <= 6      2
    ...  6 < ${order} <= 9      3

    ${order_tmp} =  evaluate  ${order} - 3*(${row}-1)
    ${order_new} =  set variable if  ${row} == 1    ${order}    ${order_tmp}
    ${order_new} =  convert to string  ${order_new}
    ${row} =        convert to string  ${row}
    [Return]  ${row}  ${order_new}

Like Photo In Profile
    run keyword and ignore error  wait until element is visible  xpath://span[@aria-label='Comment']  timeout=10s
    ${status} =  run keyword and return status  page should contain element   xpath://span[@aria-label='Share Post']/parent::*/parent::*/parent::*/span[1]/button/span[@aria-label='Like']
    run keyword if  ${status}  click element  xpath://span[@aria-label='Share Post']/parent::*/parent::*/parent::*/span[1]/button/span[@aria-label='Like']

Photo Opened Successfully
    wait until element is visible  ${ID_Like}

Like Photo
    ${status} =  run keyword and return status  page should contain element   ${ID_Like}
    run keyword if  ${status}  click element  ${ID_Like}
    sleep  2s

Move Next Photo In The Right
    wait until element is visible  ${ID_Btn_Next}  timeout=5s
    click element  ${ID_Btn_Next}
    sleep  2s

Close Profile Tab
    close window


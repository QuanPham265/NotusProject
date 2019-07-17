*** Settings ***
Library  SeleniumLibrary
Library  Dialogs
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/Process.py
Library  OperatingSystem
Resource  ./Resources/Function.robot

Test Setup      PO_MainPage.Begin Web Test
Test Teardown   PO_MainPage.End Web Test


*** Variables ***
${URL}              https://www.instagram.com/?hl=en
${URL_LogIn}        https://www.instagram.com/accounts/login/?hl=en&source=auth_switcher
${BROWSER}          ff
@{USERNAME}         pm_quan    miwa.dol
@{PASSWORD}         Tdh@2019   QPM260592
${MY_INSTAGRAM}     https://www.instagram.com/pm_quan/
${TAGS}             buonmathuot
${TAGS_PROVINCE}    phanthiet   muine       binhthuan       mũiné
...                 vietnam     hochiminh   hcm             green
${TAGS_SONY}        sonya6000   sonygram    sonyvietnam     alphagram   sonyalpha6000
${TAGS_HCM}         saigon      hochiminh   hcm             saigonese
${TAGS_DALAT}       dalat       đàlạt
${TAGS_BEACH}       beach       summer
${TAGS_TRAVEL}      travel      travelgram  travelphotography  photoshoot  photooftheday  picoftheday  travelholic
${TAGS_INSTA}       instagood   instadaily  instago  instatravel    instaphoto
${TAGS_MIND}        peaceful
${TAGS_YOGA}        yogalife    yogahcm  yogasaigon  lifeisbeautiful  reflection  balance  calmness  yogivietnam  yogastudio
${TAGS_NATURE}      naturephotography   green
&{Nb_liker}     hoangmy_likemulto=1193    hoangmy_like=2860  hoangmy_follow=1900  odcc_like=6442


# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF -i all notus_instagram.robot
*** Test Cases ***
Like Mass Photos By Popular Hashtag
    [Tags]  hashtag  all
    Function.Navigate To Instagram Web  ${URL}
    Search Tags  vscovietnam
    run keyword and ignore error  Like Sequentially With Number Account  300
#    run    pmset sleepnow


Like Potential Instagram Profile
    [Tags]  potential  all
    :FOR  ${row}  IN RANGE  2200  2400   #odcc 6442
    \   Function.Navigate To Instagram Web  ${URL}
    \   ${user_profile_name} =  Function.Read User Profile Name From File Excel  profile_kol=odcc  row=${row}  sheet=user_like
    \   log to console  ${\n}${row}. User Profile: ${user_profile_name}
    \   run keyword and ignore error  Function.Go Directly To User Profile  ${user_profile_name}
    run    pmset sleepnow


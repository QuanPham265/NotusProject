*** Settings ***
Library  SeleniumLibrary
Library  Dialogs
Library  /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/robot/libraries/Process.py
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
${TAGS_TRAVEL}      travel      travelgram  travelphotography  photoshoot  photooftheday  picoftheday
${TAGS_INSTA}       instagood   instadaily  instago  instatravel    instaphoto
${TAGS_MIND}        peaceful
${TAGS_YOGA}        yogalife    yogahcm  yogasaigon  lifeisbeautiful  reflection  balance  calmness  yogivietnam  yogastudio
${TAGS_NATURE}      naturephotography   green


# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF  -i start notus_instagram.robot
*** Test Cases ***
Like Photo In List Given Profile Name
    [Tags]  start
    Function.Navigate To Instagram Web  ${URL}
    Search Tags  photooftheday
    run keyword and ignore error  Like Sequentially With Number Account  400
#    run process  pmset displaysleepnow


Draft
    [Tags]  draft
    Function.Log In  ${URL}  ${URL_LogIn}  @{USERNAME}[1]  @{PASSWORD}[1]
    Function.Go Directly To User Profile  chefvanessalauren
    pause execution

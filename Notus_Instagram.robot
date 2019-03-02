*** Settings ***
Library  SeleniumLibrary
Library  Dialogs
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
# robot -d /Users/notuspham/Downloads/Log_RF notus_instagram.robot
*** Test Cases ***
Like Photo In List Given Profile Name
    Function.Log In  ${URL}  ${URL_LogIn}  @{USERNAME}[1]  @{PASSWORD}[1]
    Search Tags  travelphotography
    run keyword and ignore error  Like Sequentially With Number Account  1
    pause execution
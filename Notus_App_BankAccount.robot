*** Settings ***
Library  AppiumLibrary
Resource  ./Resources/common.robot

Test Setup      common.Test App Android
Test Teardown   common.End App

# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF notus_app_bankaccount.robot

*** Variables ***


*** Test Cases ***
Begin Easy
    sleep  1000s
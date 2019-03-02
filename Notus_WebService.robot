*** Settings ***
Library  RequestsLibrary

*** Variables ***


*** Keywords ***

# HOW TO RUN
# robot -d /Users/notuspham/Downloads/Log_RF notus_webservice.robot
# robot -d results notus_instagram.robot

*** Test Cases ***
Get All User
    create session  freeapi  https://jsonplaceholder.typicode.com  verify=True
    ${resp} =  get request  freeapi  /posts/1
    ${jsondata} =  To Json  ${resp.content}
    log   ${resp}
    log   ${jsondata}


Get Requests with Json Data
    [Tags]  get
    Create Session  httpbin     http://httpbin.org
    &{data} =    Create Dictionary   latitude=30.496346  longitude=-87.640356
    ${resp}=     Get Request  httpbin  /get    json=${data}
    Should Be Equal As Strings  ${resp.status_code}  200
    ${jsondata}=  To Json  ${resp.content}
    # httpbin does not support this... Should Be Equal     ${jsondata['json]}     ${data}

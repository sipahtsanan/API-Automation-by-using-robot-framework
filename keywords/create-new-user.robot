*** Settings ***
Resource      ../resources/import.robot


*** Keywords ***
Call Create a new user With JSON Body
    [Arguments]    ${jsonbody}
    Create Session    post_create_new_user         ${exam_url}          disable_warnings=${1}
    &{headers}=  Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${token}
    [Return]  ${headers}
    ${resp}=    POST Request         post_create_new_user             ${uri}               data=${jsonbody}    headers=${headers}
    Run Keyword If    ${resp.status_code} == 200    Set Global Variable    ${json_resp}    ${resp.json()}
    Set Global Variable    ${response}    ${resp}

   ${userInfo['id']}=  Get Value From Json       ${json_resp}        $..id
   Log           ${userInfo['id']}
   ${id}=    Get From List    ${userInfo['id']}    0
   Set Global Variable    ${user_id}    ${id}
   Log           ${user_id}

   ${userInfo['email']}=  Get Value From Json       ${json_resp}        $..email
   Log           ${userInfo['email']}
   ${email}=    Get From List    ${userInfo['email']}    0
   Set Global Variable    ${user_email}    ${email}
   Log           ${user_email}

   ${userInfo['name']}=  Get Value From Json       ${json_resp}        $..name
   Log           ${userInfo['name']}
   ${name}=    Get From List    ${userInfo['name']}    0
   Set Global Variable    ${user_name}    ${name}
   Log           ${user_name}

Prepare New user data Info
    Get Rand Letters and Numbers    3
    Update 'name' Is 'CreateNewUser ${rand_str}' For Request
    Get Rand Letters and Numbers    3
    Update 'email' Is 'test.create_data${rand_str}@15ce.com' For Request


Verify create a new user is successfully
   Create Session    get_search_user    ${exam_url}       disable_warnings=${1}
   &{headers}=  Create Dictionary
     ...    Content-Type=application/json
     ...    Authorization=Bearer ${token}
     [Return]  ${headers}
     ${response}=    Get Request    get_search_user    ${uri}/${user_id}         headers=${headers}

   Set Test Variable    ${response}


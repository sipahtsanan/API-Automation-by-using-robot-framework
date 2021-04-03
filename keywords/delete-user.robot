*** Settings ***
Resource      ../resources/import.robot


*** Keywords ***
Call delete the user With JSON Body
    [Arguments]    ${userId}
    Create Session    delete_the_user         ${exam_url}          disable_warnings=${1}
    &{headers}=  Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${token}
    [Return]  ${headers}
    ${resp}=    DELETE REQUEST         delete_the_user             ${uri}/${userId}               headers=${headers}
    Run Keyword If    ${resp.status_code} == 200    Set Global Variable    ${json_resp}    ${resp.json()}
    Set Global Variable    ${response}    ${resp}


Verify delete the user successfully
   [Arguments]    ${userId}
   Create Session    get_search_user    ${exam_url}       disable_warnings=${1}
   &{headers}=  Create Dictionary
     ...    Content-Type=application/json
     ...    Authorization=Bearer ${token}
     [Return]  ${headers}
     ${response}=    Get Request    get_search_user    ${uri}/${user_id}         headers=${headers}
   Set Test Variable    ${response}
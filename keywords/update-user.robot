*** Settings ***
Resource      ../resources/import.robot


*** Keywords ***
Calling Rename user API
    [Arguments]   ${userId}    ${data_post}
    Create Session    PUT_rename_user     ${exam_url}        disable_warnings=${1}
    &{headers}=  Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${token}
    [Return]  ${headers}
    ${resp}=    Put Request      PUT_rename_user          ${uri}/${userId}         data=${data_post}         headers=${headers}
    Run Keyword If    ${resp.status_code} == 200    Set Test Variable    ${json_resp}    ${resp.json()}
    Set Global Variable       ${response}    ${resp}

Prepare JSON file for Updating request data
  &{Rename_user}   create dictionary
    ...   name=Rename the user succeed

   Return From Keyword    ${Rename_user}

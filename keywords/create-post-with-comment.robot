*** Settings ***
Resource      ../resources/import.robot


*** Keywords ***
Call Create post With JSON Body
    [Arguments]    ${userId}     ${jsonbody}
    Create Session    post_create_post         ${exam_url}          disable_warnings=${1}
    &{headers}=  Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${token}
    [Return]  ${headers}
    ${resp}=    POST Request         post_create_post             ${uri}/${userId}/posts               data=${jsonbody}    headers=${headers}
    Run Keyword If    ${resp.status_code} == 200    Set Global Variable    ${json_resp}    ${resp.json()}
    Set Global Variable    ${response}    ${resp}

   ${postInfo['id']}=  Get Value From Json       ${json_resp}        $..id
   Log           ${postInfo['id']}
   ${post_id}=    Get From List    ${postInfo['id']}    0
   Set Global Variable    ${postID}    ${post_id}
   Log           ${postID}

   ${postInfo['body']}=  Get Value From Json       ${json_resp}        $..body
   Log           ${postInfo['body']}
   ${post_body}=    Get From List    ${postInfo['body']}    0
   Set Global Variable    ${postBODY}    ${post_body}
   Log           ${postBODY}

   ${postInfo['title']}=  Get Value From Json       ${json_resp}        $..title
   Log           ${postInfo['title']}
   ${post_title}=    Get From List    ${postInfo['title']}    0
   Set Global Variable    ${postTITLE}    ${post_title}
   Log           ${postTITLE}

Call Create comment With JSON Body
    [Arguments]    ${postId}     ${jsonbody}
    Create Session    post_create_comment         ${exam_url}          disable_warnings=${1}
    &{headers}=  Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${token}
    [Return]  ${headers}
    ${resp}=    POST Request         post_create_comment             ${uri_post}/${postId}/comments               data=${jsonbody}    headers=${headers}
    Run Keyword If    ${resp.status_code} == 200    Set Global Variable    ${json_resp}    ${resp.json()}
    Set Global Variable    ${response}    ${resp}

Prepare JSON file for Creating comment request data
  &{comment_body}   create dictionary
    ...   name=${user_name}
    ...   email=${user_email}
    ...   body=Test inputting message in Comment body
    ...   title=Test inputting message in Comment title
   Return From Keyword    ${comment_body}

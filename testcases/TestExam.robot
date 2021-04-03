  #coding: utf-8

*** Settings ***
Resource          ../resources/import.robot



*** Test Cases ***

TC_O001
  [Documentation]  Verify Create a new user in the system and make the corresponding assertions to confirm the data persists
           Given Prepare Json Request    ${create_newUser_requestBody}
           Then Prepare New user data Info
           When Call Create a new user With JSON Body      ${request}
           Then Http Response Should Be '200'
           And Verify create a new user is successfully
           And Response Field 'email' Should Be Equal '${user_email}'


  [Documentation]  Verify Rename the user and check it was correctly updated in the system

           ${startRename_user}=   Prepare JSON file for Updating request data
           Then Calling Rename user API        ${user_id}       ${startRename_user}
           And Http Response Should Be '200'
           And Response Field 'email' Should Be Equal '${user_email}'
           And Response Field 'id' Should Be Equal '${user_id}'
           And Response Field 'name' Should Not Be Equal '${user_name}'


  [Documentation]  Verify Create a post with 1 comment as the above user. Check the comment persists and is related with the correct user

           Then Call Create post With JSON Body        ${user_id}       ${create_post}
           And Http Response Should Be '200'
           And Response Field 'user_id' Should Be Equal '${user_id}'
           ${commentJSONBody}=  Prepare JSON file for Creating comment request data
           Then Call Create comment With JSON Body     ${postID}     ${commentJSONBody}
           And Response Field 'post_id' Should Be Equal '${postID}'
           And Response Field 'name' Should Be Equal '${user_name}'
           And Response Field 'email' Should Be Equal '${user_email}'
           And Response Field 'body' Should Be Contain 'Test inputting message in Comment body'


  [Documentation]  Verify delete the user and confirm the previously generated data is no longer accessible.

           Then Call delete the user With JSON Body        ${user_id}
           And Http Response Should Be '200'
           And Verify delete the user successfully         ${user_id}
           And Response Field 'code' Should Be Equal '404'
           And Response Field 'message' Should Be Contain 'Resource not found'


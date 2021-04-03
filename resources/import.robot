*** Settings ***
Library    Collections
Library    String
Library    HttpLibrary.HTTP
Library    RequestsLibrary
Library    JSONLibrary
Library    json


### KEYWORDS ###
Resource     ../keywords/common_keywords.robot
Resource     ../keywords/create-new-user.robot
Resource     ../keywords/update-user.robot
Resource     ../keywords/create-post-with-comment.robot
Resource     ../keywords/delete-user.robot


### VARIABLES ###
Resource    testdata/create_post-with-comment.txt
Resource    testdata/create_newUser.txt
Resource         ../resources/configs.robot

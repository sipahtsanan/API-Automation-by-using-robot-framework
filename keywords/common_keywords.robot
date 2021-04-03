*** Settings ***
Resource    ../resources/import.robot

*** Keywords ***

################################# GENERATE RANDOM #################################
Get Rand Letters and Numbers
    [Arguments]    ${length}
    ${rand_str}=    Generate Random String    ${length}    [LETTERS][NUMBERS]
    Set Test Variable    ${rand_str}    ${rand_str}

##################################################################

Prepare Json Request
    [Arguments]    ${template}
    ${request}=     Copy Dictionary    ${template}
    Set Test Variable    ${request}    ${request}


Update '${field}' Is '${value}' For Request
    ${request}=    Update Value To Json    ${request}    $..${field}    ${value}
    Set Test Variable    ${request}


################################# VERIFICATION #################################
Http Response Should Be '${http_status}'
    ${status}=    Set Variable    ${response.status_code}
    Log    ${response.text}
    Should Be Equal As Integers    ${status}    ${http_status}

Response Field '${json_path}' Should Be Equal '${expected}'
    ${response.json}=    To Json    ${response.text}
    ${actual}=    Get Value From Json    ${response.json}    $..${json_path}
    Should Be Equal As Strings    ${actual[0]}    ${expected}
    Log    ${actual[0]}
    Log    ${expected}

Response Field '${json_path}' Should Not Be Equal '${value}'
    ${response.json}=    To Json    ${response.text}
    ${actual}=    Get Value From Json    ${response.json}    $..${json_path}
    Should Not Be Equal As Strings    ${actual[0]}    ${value}
    Log    ${actual[0]}
    Log    ${value}

Response Field '${json_path}' Should Be Contain '${expected}'
    ${response.json}=    To Json    ${response.text}
    ${actual}=    Get Value From Json    ${response.json}    $..${json_path}
    Get Lines Containing String    ${actual[0]}    ${expected}


*** Keywords ***
Verify and input text
    [Arguments]    ${element}    ${value}
    Page Should Contain Element   ${element}
    Input Text    ${element}    ${value}

Verify and click button
    [Arguments]    ${element}
    Page Should Contain Button    ${element}
    Click Button    ${element}

Get user JSON data
    # Create session    alias=user    url=${dashboard_bluestone}
    ${response}=    GET    ${user_json}
    Log    ${response.json()}
    Log    ${response.text}

    [Return]    ${response.json()}
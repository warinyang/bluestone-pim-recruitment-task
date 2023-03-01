*** Settings ***
Resource    ../resources/imports.resource
Resource    ../keywords/common_keyword.robot
Resource    ../keywords/logout_keyword.robot


Test Setup    Open login page
Test Teardown    Close browser

*** Test Cases ***
TC08 - Should logout successfully and return to login page
    [Tags]    logout
    Input for login page
    Verify and click button    ${logout_button}
    Element Should Be Visible    ${logout_label}
    Set Focus To Element    ${logout_label}
    Click Element    ${logout_label}
    Verify back to login page

    
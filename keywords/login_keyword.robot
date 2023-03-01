# *** Settings ***
# Resource    ../resources/imports.resource

*** Keywords ***
Open login page
    Open Browser    ${dashboard_bluestone}    browser=chrome
    Page Should Contain    Welcome!

Verify login should chage to dashboard
    Wait Until Page Contains Element    ${search_input}
    Page Should Contain Element    ${search_input}
    Wait Until Page Contains Element    ${dashboard_table}
    Page Should Contain Element    ${dashboard_table}

Verify login should show error
    [Arguments]    ${error_text}    ${element}
    Wait Until Page Contains Element    ${element}
    Element Should Be Visible    ${element}
    Page Should Contain    ${error_text}
    
Verify login should submit success and show error 
    Wait Until Page Contains Element    ${invalid_username_password}
    Element Should Be Visible    ${invalid_username_password}


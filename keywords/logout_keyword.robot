*** Settings ***
Resource    ../keywords/login_keyword.robot

*** Keywords ***
Input for login page
    Verify and input text    element=${email_input}    value=${success_email}
    Verify and input text    element=${password_input}    value=${success_password}
    Verify and click button    ${login_button}
    Verify login should chage to dashboard

Verify back to login page
    Page Should Contain    Welcome!
    
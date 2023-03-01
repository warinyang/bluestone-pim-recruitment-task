*** Settings ***
Resource    ../resources/imports.resource
# Keywords Import
Resource    ../keywords/common_keyword.robot
Resource    ../keywords/login_keyword.robot

Test Setup    Open login page
Test Teardown    Close browser 

*** Test Cases ***
TC01 - Should login success when input correct username and password
    [Tags]    login
    Verify and input text    element=${email_input}    value=${success_email}
    Verify and input text    element=${password_input}    value=${success_password}
    Verify and click button    ${login_button}
    Verify login should chage to dashboard

TC02 - Should login failed show text error when input blank username
    [Tags]    login
    Click Element    ${email_input}
    Verify and input text    element=${password_input}    value=${success_password}
    Verify and click button    ${login_button}
    Verify login should show error    error_text=Email is not valid    element=${email_error}
    
TC03 - Should login failed show text error when input blank password
    [Tags]    login
    Verify and input text    element=${email_input}    value=${success_email}
    Click Element    ${password_input}
    Verify and click button    ${login_button}
    Verify login should show error    error_text=Please enter your password    element=${password_error}

TC04 - Should login failed show text error when input blank username and password
    [Tags]    login
    Click Element    ${email_input}
    Click Element    ${password_input}
    Verify and click button    ${login_button}
    Verify login should show error    error_text=Email is not valid    element=${email_error}
    Verify login should show error    error_text=Please enter your password    element=${password_error}

TC05 - Should login failed show text error when input invalid format email
    [Tags]    login
    Verify and input text    element=${email_input}    value=${invalid_email}
    Verify and input text    element=${password_input}    value=${success_password}
    Verify and click button    ${login_button}
    Verify login should show error    error_text=Email is not valid    element=${email_error}

TC06 - Should login failed show text error when input wrong email
    [Tags]    login
    Verify and input text    element=${email_input}    value=${wrong_email}
    Verify and input text    element=${password_input}    value=${success_password}
    Verify and click button    ${login_button}
    Verify login should submit success and show error 

TC07 - Should login failed show text error when input wrong password
    [Tags]    login
    Verify and input text    element=${email_input}    value=${success_email}
    Verify and input text    element=${password_input}    value=${wrong_password}
    Verify and click button    ${login_button}
    Verify login should submit success and show error 
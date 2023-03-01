*** Settings ***
Resource    ../keywords/login_keyword.robot
Resource    ../keywords/logout_keyword.robot
Resource    ../keywords/common_keyword.robot
Resource    ../resources/imports.resource

*** Variables ***
${row_per_page}    5

*** Keywords ***
Open browser and login
    Open login page
    Verify and input text    element=${email_input}    value=${success_email}
    Verify and input text    element=${password_input}    value=${success_password}
    Verify and click button    ${login_button}
    Verify login should chage to dashboard

Logout and close browser
    Verify and click button    ${logout_button}
    Element Should Be Visible    ${logout_label}
    Set Focus To Element    ${logout_label}
    Click Element    ${logout_label}
    Verify back to login page
    Close Browser

Check fields show correct
    [Arguments]    ${xpath}    ${fields_name}    ${json_key_name}    ${JSON}    ${number_of_cilck_page}

    ${json_start}=    Evaluate    ${number_of_cilck_page}*${row_per_page}
    ${index} =    Set Variable    ${json_start}

    ${elements}   Get WebElements   xpath=${xpath}
    FOR   ${element}   IN   @{elements}
        ${text}   Get Text   ${element}
        IF    "${text}"!="${fields_name}"
            IF    "${text}"=="${EMPTY}"
                Should Be Equal    ${JSON}[${index}][${json_key_name}]    ${None}
            ELSE 
                Should Be Equal As Strings    ${text}    ${JSON}[${index}][${json_key_name}]
            END
            ${index}=    Evaluate    ${index} + 1
        END
    END

Check fields full name correct
    [Arguments]    ${xpath}    ${JSON}    ${number_of_cilck_page}
    ${json_start}=    Evaluate    ${number_of_cilck_page}*${row_per_page}
    ${index} =    Set Variable    ${json_start}
    ${elements}   Get WebElements   xpath=${xpath}
    # Log To Console     ${full_name}
        FOR   ${element}   IN   @{elements}
        ${text}   Get Text   ${element}
        IF    "${text}"!="Full name"
                IF    "${JSON}[${index}][firstName]"=="${None}"
                    ${full_name} =    Catenate    ${JSON}[${index}][firstName]
                ELSE IF    "${JSON}[${index}][lastName]"=="${None}"
                    ${full_name} =    Catenate    ${JSON}[${index}][lastName]
                ELSE 
                    ${full_name} =    Catenate    ${JSON}[${index}][firstName]    ${JSON}[${index}][lastName]
                    Should Be Equal As Strings    ${text}    ${full_name}
                END    
            ${index}=    Evaluate    ${index} + 1
        END
    END

Click to next page
    Verify and click button    ${next_page_button}

Verify page number
    [Documentation]    To verify page number that show on screen are correct

    [Arguments]    ${number_of_cilck_page}    ${JSON}
    ${length}=    Get length    ${JSON}
    
    ${row_left}=    Evaluate    ${length}-${number_of_cilck_page}*${row_per_page}
    ${row_page_start}=    Evaluate    ${number_of_cilck_page}*${row_per_page}+1

    ${page_start_number}=    Get Text    ${page_show_number}
    ${page_start_number}=    Get Substring    ${page_start_number}    0    1
    # Log To Console    ${page_start_number} 
    Should Be Equal    "${page_start_number}"    "${row_page_start}"

Verify search data 
    [Arguments]    ${text}

    ${JSON}=    Get user JSON data

    Input Text    ${search_input}    ${text}
    Sleep   1
    ${length}=    Get length    ${JSON}
    @{found_data_first_name}    Create list
    @{found_data_last_name}    Create list


    # search from first name
    FOR    ${index}    IN RANGE    0    ${length}
         IF    "${JSON}[${index}][firstName]"!="${None}"
            ${result}=    Index Of   ${JSON}[${index}][firstName]    ${text}
            IF    ${result} != -1
                Append To List    ${found_data_first_name}    ${text}   
            END
         END
    END

    # search from last name
    FOR    ${index}    IN RANGE    0    ${length}
          IF    "${JSON}[${index}][lastName]"!="${None}"
            ${result}=    Index Of   ${JSON}[${index}][lastName]    ${text}
            IF    ${result} != -1
                Append To List    ${found_data_last_name}    ${text}   
            END
         END
    END

    ${first_name_is_empty}=    Run Keyword And Return Status    Should Be Empty    ${found_data_first_name}
    ${last_name_is_empty}=    Run Keyword And Return Status    Should Be Empty    ${found_data_last_name}


    IF    ${first_name_is_empty} and ${last_name_is_empty}
        # always show first page
        Check fields show correct    xpath=${id_fields}    fields_name=ID    json_key_name=id    JSON=${JSON}    number_of_cilck_page=0 
        Check fields show correct    xpath=${first_name_fields}    fields_name=First name    json_key_name=firstName    JSON=${JSON}    number_of_cilck_page=0 
        Check fields show correct    xpath=${last_name_fields}    fields_name=Last name    json_key_name=lastName    JSON=${JSON}    number_of_cilck_page=0
        Check fields show correct    xpath=${age_fields}    fields_name=Age    json_key_name=age    JSON=${JSON}    number_of_cilck_page=0
        Check fields full name correct    xpath=${full_name_fields}    JSON=${JSON}    number_of_cilck_page=0
    ELSE
        Verify result are match in search    ${found_data_first_name}    ${found_data_last_name}    ${first_name_is_empty}    ${last_name_is_empty}
    END

Verify result are match in search
    [Arguments]    ${list_first_name}    ${list_last_name}    ${first_name_is_empty}    ${last_name_is_empty}
    ${first_name_elements}   Get WebElements   xpath=${first_name_fields}
    ${last_name_elements}   Get WebElements   xpath=${last_name_fields}

     IF    ${first_name_is_empty} == False
        FOR    ${first_name}    IN    @{list_first_name}
            ${first_name_text}   Get Text   ${first_name_elements}
            IF    "${first_name_text}"!="First name"
                Should Be Equal As Strings    ${first_name_text}    ${first_name}
            END
        END
     END
    IF    ${last_name_is_empty} == False
        FOR    ${lastname}    IN    @{list_last_name}
            ${last_name_text}   Get Text   ${last_name_elements}
            IF    "${last_name_text}"!="Last name"
                Should Be Equal As Strings    ${last_name_text}    ${lastname}
            END
        END
     END


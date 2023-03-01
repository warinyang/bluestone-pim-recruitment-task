*** Settings ***
Resource    ../resources/imports.resource
# Keywords Import
Resource    ../keywords/common_keyword.robot
Resource    ../keywords/dashboard_keyword.robot

Test Setup    Open browser and login
Test Teardown    Close Browser

*** Test Cases ***
TC09 - Dashboard should show all first 5 row 
    ${userJson}=    Get user JSON data
    Check fields show correct    xpath=${id_fields}    fields_name=ID    json_key_name=id    JSON=${userJson}    number_of_cilck_page=0 
    Check fields show correct    xpath=${first_name_fields}    fields_name=First name    json_key_name=firstName    JSON=${userJson}    number_of_cilck_page=0 
    Check fields show correct    xpath=${last_name_fields}    fields_name=Last name    json_key_name=lastName    JSON=${userJson}    number_of_cilck_page=0
    Check fields show correct    xpath=${age_fields}    fields_name=Age    json_key_name=age    JSON=${userJson}    number_of_cilck_page=0
    Check fields full name correct    xpath=${full_name_fields}    JSON=${userJson}    number_of_cilck_page=0

TC10 - Dashboard should show row of new page
    ${userJson}=    Get user JSON data
    Click to next page
    Verify page number    number_of_cilck_page=1    JSON=${userJson}
    Check fields show correct    xpath=${id_fields}    fields_name=ID    json_key_name=id    JSON=${userJson}    number_of_cilck_page=1 
    Check fields show correct    xpath=${first_name_fields}    fields_name=First name    json_key_name=firstName    JSON=${userJson}    number_of_cilck_page=1 
    Check fields show correct    xpath=${last_name_fields}    fields_name=Last name    json_key_name=lastName    JSON=${userJson}    number_of_cilck_page=1
    Check fields show correct    xpath=${age_fields}    fields_name=Age    json_key_name=age    JSON=${userJson}    number_of_cilck_page=1
    Check fields full name correct    xpath=${full_name_fields}    JSON=${userJson}    number_of_cilck_page=1


TC11 - Should show all data correctly
    [Template]    Verify search data
    FFFFFFF
    Jon
    Snow
    Lannister


TC12 - Should change page to dark theme when switch dark mode
    Element Should Be Visible    ${light_mode_icon}
    Click Element    ${light_mode_icon}
    Element Should Be Visible    ${dark_mode_icon}

TC13 - Should change page to light theme when switch light mode
    Element Should Be Visible    ${light_mode_icon}
    Click Element    ${light_mode_icon}
    Element Should Be Visible    ${dark_mode_icon}
    Click Element    ${dark_mode_icon}
    Element Should Be Visible    ${light_mode_icon}





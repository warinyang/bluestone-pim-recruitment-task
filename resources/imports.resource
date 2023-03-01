*** Settings ****
Library    Collections
Library    SeleniumLibrary
Library    String
Library    OperatingSystem
Library    RequestsLibrary
Library    ../resources/libs/MyCustomLib.py

Variables    ../resources/common_config.yaml
Variables    ../resources/screen_elements/login_screen.yaml
Variables    ../resources/screen_elements/dashboard_screen.yaml
Variables    ../resources/test-data/login.yaml
Variables    ../resources/test-data/search.yaml



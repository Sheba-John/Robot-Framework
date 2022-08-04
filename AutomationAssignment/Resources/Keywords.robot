*** Settings ***
Library    SeleniumLibrary
Variables    ../PageObject/Locator.py

*** Keywords ***
Enter Username
    [Arguments]    ${username}
    input text    ${txt_loginUserName}  ${username}

Enter Password
    [Arguments]    ${password}
    input text    ${txt_loginPassword}  ${password}

Click SignIn
    click button    ${btn_signIn}

Verify Successful login
    title should be    Neova Task Base

close my browsers
    close all browsers


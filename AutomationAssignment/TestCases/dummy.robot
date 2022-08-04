*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Test Cases ***
Fill timesheet
    ${date}=     Get Current Date    result_format=%d-Aug-%Y
    log to console    ${date}

    ${new_date}=    Get Current Date    result_format=%m/%d/%Y    increment=1 day   result_format=%d-Aug-%Y
    log to console  ${new_date}

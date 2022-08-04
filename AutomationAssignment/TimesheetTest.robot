*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Keywords.robot
Library    DateTime
*** Variables ***
${SiteUrl}  http://114.143.149.14:4356/TaskbaseAWS-2.0/NeovaTaskBase/LoginPage.aspx
${User}     sheba_john@neovasolutions.in
${pwd}  Neova@123
${descriptn}  Automation training assignment using selenium or robot framework with python
${descriptn2}     Automation training

*** Test Cases ***
LoginTest
    set selenium implicit wait    5seconds
     ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Create WebDriver    Chrome    chrome_options=${options}
    Go To   ${SiteUrl}
    maximize browser window
    Enter Username  ${User}
    Enter Password  ${pwd}
    Click SignIn
    Verify Successful login

    #Positive Scenario
Fill timesheet
#    Validate My Timesheet is displayed
    page should contain    My Timesheet

#    Validate My name is displayed
    list selection should be    ctl00_ContentPlaceHolder1_ddEmployee    Sheba John

#   select today’s date
    ${date}=     Get Current Date    result_format=%d-Aug-%Y
    log to console    ${date}
    ${"current_date"}  set variable    xpath://input[@id='ctl00_ContentPlaceHolder1_txtEntryDate']
    input text    ${"current_date"}    ${date}

#   Click on Projects dropdown and select project NON_BILLABLE
    select from list by label   ctl00_ContentPlaceHolder1_ddProjects    NON-BILLABLE
    sleep    5seconds

#   Click on Phase dropdown and select Phase Training – Internal
    select from list by value    ctl00_ContentPlaceHolder1_ddPhase  Training - Internal

#   Click on Total Hours dropdown and select value 7
    select from list by value    ctl00_ContentPlaceHolder1_ddEntryHours     7

#   Enter text in Description textbox as Automation training assignment using selenium or robot framework with python
    ${"Description"}  set variable    xpath://textarea[@id='ctl00_ContentPlaceHolder1_txtDescription']
    input text  ${"Description"}  ${descriptn}

#    Click on the Add button
    click element    xpath://input[@id='ctl00_ContentPlaceHolder1_btnAddTimesheetEntry']

#   Enter text in Description textbox as team meeting
    select from list by value   ctl00_ContentPlaceHolder1_ddEntryHours     1
    input text  ${"Description"}    team meeting

#    Click on the Add button
    click element    xpath://input[@id='ctl00_ContentPlaceHolder1_btnAddTimesheetEntry']
    sleep    5seconds

# Validate Description column first row text must be equal to the text mentioned during Step 8 (Automation training assignment using selenium or robot framework with python)
    ${response}=    get text    xpath://*[@id="ctl00_ContentPlaceHolder1_gvTimesheet"]/tbody/tr[2]/td[4]
    should be equal    ${response}   ${descriptn}


 #   Negative Scenario
#    Select a future date
    ${new_date}=    Get Current Date    result_format=%m/%d/%Y    increment=1 day   result_format=%d-Aug-%Y
    log to console  ${new_date}
    ${"next_date"}  set variable    xpath://input[@id='ctl00_ContentPlaceHolder1_txtEntryDate']
    press keys    ${"next_date"}    CTRL+a+BACKSPACE
    input text    ${"next_date"}    ${new_date}

#    Click on Total Hours dropdown and select value
    select from list by value    ctl00_ContentPlaceHolder1_ddEntryHours     8

#   Enter text in Description textbox as Automation Training
    press keys    ${"Description"}  CTRL+a+BACKSPACE
    input text  ${"Description"}  ${descriptn2}

#   Click on the Add button
    click element    xpath://input[@id='ctl00_ContentPlaceHolder1_btnAddTimesheetEntry']
    Sleep   5seconds
#    Validate the error message for entering furture date
    page should contain    Future timesheet entries not allowed

    close browser


*** Keywords ***


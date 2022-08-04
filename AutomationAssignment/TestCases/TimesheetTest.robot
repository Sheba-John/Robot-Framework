*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Keywords.robot

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
    page should contain    My Timesheet
    list selection should be    ctl00_ContentPlaceHolder1_ddEmployee    Sheba John
    click element    xpath://span[@id='imgBtnCal']
    press keys    xpath://span[@id='imgBtnCal']     ENTER
    select from list by label   ctl00_ContentPlaceHolder1_ddProjects    NON-BILLABLE
    sleep    5seconds
    select from list by value    ctl00_ContentPlaceHolder1_ddPhase  Training - Internal
    select from list by value    ctl00_ContentPlaceHolder1_ddEntryHours     7
    ${"Description"}  set variable    xpath://textarea[@id='ctl00_ContentPlaceHolder1_txtDescription']
    input text  ${"Description"}  ${descriptn}
    click element    xpath://input[@id='ctl00_ContentPlaceHolder1_btnAddTimesheetEntry']
    select from list by value   ctl00_ContentPlaceHolder1_ddEntryHours     1
    input text  ${"Description"}    team meeting
    click element    xpath://input[@id='ctl00_ContentPlaceHolder1_btnAddTimesheetEntry']
    sleep    5seconds
    ${response}=    get text    xpath://*[@id="ctl00_ContentPlaceHolder1_gvTimesheet"]/tbody/tr[2]/td[4]
    should be equal    ${response}   ${descriptn}


 #   Negative Scenario

    ${"next_date"}  set variable    xpath://input[@id='ctl00_ContentPlaceHolder1_txtEntryDate']
    press keys    ${"next_date"}    CTRL+a+BACKSPACE
    input text    ${"next_date"}    06-Aug-2022
    select from list by value    ctl00_ContentPlaceHolder1_ddEntryHours     8
    press keys    ${"Description"}  CTRL+a+BACKSPACE
    input text  ${"Description"}  ${descriptn2}
    click element    xpath://input[@id='ctl00_ContentPlaceHolder1_btnAddTimesheetEntry']
    Sleep   5seconds
    page should contain    Future timesheet entries not allowed

    close browser




*** Keywords ***


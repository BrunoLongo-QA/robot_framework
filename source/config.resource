# [Documentation]    Author: Bruno Longo
# ...                Version: 1.1
# ...                Description: Resource file for the Robot Show Off
# ...                Log Location: ../log

*** Settings ***
Library            SeleniumLibrary
Library            ScreenCapLibrary
Library            OperatingSystem
Library            String
LIbrary            RequestsLibrary
Library            Collections

*** Variables ***
## To test on QA
${url}             https://qa.blueops.net/tupix
## To test local
#${url}             https://local.blueops.net/tupix
${browser}         firefox
@{w3id}    
${apiToken}       
${apiURL}     

*** Keywords ***
New Visual Session
    Set Selenium Speed                 0.01 seconds
    Open Browser                       about:blank                                                 ${browser}
    Maximize Browser Window
    Go To                              ${url}
    Login W3ID
    #Start Gif Recording
    Wait Until Element Is Visible     css:body > nav > div > div.navbar-brand > a                  60

End Visual Session
    #Stop Gif Recording
    Close Browser

Login W3ID
    ${w3id[0]}                         Get File                                                    /Users/blongo/Documents/Particular/login.txt
    ${w3id[1]}                         Get Line                                                    ${w3id[0]}            0
    ${w3id[2]}                         Get Line                                                    ${w3id[0]}            1
    Input Text                         id:desktop                                                  ${w3id[1]}
    Input Password                     xpath://*[@aria-label="password"][@type="password"]         ${w3id[2]}
    Click Button                       id:btn_signin


Print
    Capture Page Screenshot

Access the ${client} Adhoc
    Go To                ${url}/clients/${client}/adhoc
    Title Should Be      qa Next

Select the ${playbook}
    Wait Until Element Is Enabled              id:playbook
    Select From List By Label                  id:playbook                    ${playbook}
    ${confirm}                                 Get Selected List Label        id:playbook
    Log To Console                             ${confirm}
    Should Be Equal                            ${confirm}                     ${playbook}
    
Select affected host ${host}
    Click Element                      xpath://*[@class="ms-elem-selectable"]//span[text()="${host}"]
    Page Should Contain Element        xpath://*[@class="ms-selection"]//span[text()="${host}"]
    Log To Console                     Affected Host selected. 

Input the @{parameter} for the Execution
    Input Text                       xpath://*[@class="input required"][@name="playbook_additional_params[script_path]"]          ${parameter[0]}
    Page Should Contain Textfield    xpath://*[@class="input required"][@name="playbook_additional_params[script_path]"]          ${parameter[0]}
    Input Text                       xpath://*[@class="input required"][@name="playbook_additional_params[script_params]"]        ${parameter[1]}
    Page Should Contain Textfield    xpath://*[@class="input required"][@name="playbook_additional_params[script_params]"]        ${parameter[1]}




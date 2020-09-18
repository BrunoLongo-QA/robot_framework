*** Settings ***
Documentation     Author: Bruno Longo
...               Version: 1.0
...               Description: Automation to run the PB with a visual confirmation
...               Log Location: ../log
Resource          ../source/config.resource

Suite Setup       New Visual Session
Suite Teardown    End Visual Session

*** Variable ***
${client}         g2t
${playbook}       GEN_URL_Down.yml
${host1}          (linux) labcentos6
${host2}          (linux) labcentos7
@{parameter}      scripts/linux/url_down.sh                                           w3.ibm.com
${result}         Status: successful
${time}           120

*** Test Case ***
PB Execution
    Access the ${client} Adhoc
    Select the ${playbook}
    Select affected host ${host1}
    Input the @{parameter} for the Execution
    Click Button                                xpath://*[@type="submit"][@name="commit"]
    Wait Until Page Does Not Contain Element    id:cancel-job                                ${time}
    Page Should Contain Element                 xpath://*[@class="status"]
    Print
    Page Should Contain                         ${result}


# PB Execution 2
#                 Access the ${client} Adhoc
#                 Select the ${playbook}
#                 Select affected host ${host2}
#                 Input the ${parameter[0]} for the Execution

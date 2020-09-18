*** Settings ***
Documentation      Author: Bruno Longo
...                Version: 1.3.1
...                Description: Resource file for configuration and use of ADdHoc by API Commands, on this we will have the configuration of the token file,
...                the configuration of the playbook parameters to run and the validation process.
...                For the complete documentation check: https://apps.na.collabserv.com/wikis/home?lang=en-us#!/wiki/W6f3c4680e937_4592_ae2a_bd086384af9f/page/(Draft)%20Robot%20Documentation
LIbrary            RequestsLibrary
Library            Collections
Library            String
Library            OperatingSystem
Library            BuiltIn
Library            JSONLibrary
Resource           ../config.resource

*** Keywords ***
Connect To API
    [Documentation]    Connect to Next API end point

    Create Session        NextApi        ${URLAPI}/        verify=False         disable_warnings=1

Get The Playbook Files
    [Documentation]         Check the directory and load all quantity of files and the files name for use in the loop
    
    ${SCRIPTQTD}                    Count Files In Directory                                ${PATH}
    Log To Console                  ...
    Log To Console                  Qauntity of files in the folder ${SCRIPTQTD}
    ${FILESLIST}                    List Files In Directory                                 ${PATH}
    Log To Console                  Names of the files in the Folder ${FILESLIST}
    Set Global Variable             ${SCRIPTQTD}
    Set Global Variable             ${FILESLIST}

Generate Playbook Param
    [Documentation]    Get the playbook information from file and breaked down into the CURL command line
    [Arguments]        ${FILE}
    
    ${FILE}                            Get File        ${PATH}/${FILE}  
    ${CLIENT}                          Get Line        ${FILE}              0
    ${PLAYBOOK}                        Get Line        ${FILE}              1
    ${PBGROUPS}                        Get Line        ${FILE}              2
    ${PBHOSTS}                         Get Line        ${FILE}              3
    ${PBADPARAM}                       Get Line        ${FILE}              4
    ${TIME}                            Get Line        ${FILE}              5
    ${JOB_STATUS}                      Get Line        ${FILE}              6  
    ${ADHOCSTR}                        Set Variable    { "adhoc": {"playbook": ${PLAYBOOK},"groups": [${PBGROUPS}],"hosts": [${PBHOSTS}],"playbook_additional_params":{${PBADPARAM}},"check_mode": "true"}}
    Set Global Variable                ${JOB_STATUS}
    Set Global Variable                ${ADHOCSTR}
    Set Global Variable                ${CLIENT}
    Set Global Variable                ${TIME}

##
## CODE FOR THE REQUEST EXECUTION
##
Run Playbook By Request
    [Documentation]                 This code runs the playbook by a request library and set the response global, this way we can use to validate the results.
    [Arguments]                     ${FILE}
    
    Generate Playbook Param         ${FILE}
    ${ADHOCSTR}                     Convert String to JSON              ${ADHOCSTR} 
    ${HEADERS}                      Create Dictionary                   Content-Type=application/json
    ...                                                                 Authorization=Token token=${TOKEN}
    Log To Console                  Execution of the file ${FILE}
    Log To Console                  ...
    ${RESPONSE}                     Post Request                        NextApi        
    ...                                                                 clients/${CLIENT}/adhoc/run/
    ...                                                                 data=${ADHOCSTR}
    ...                                                                 headers=${HEADERS}
    Log To Console                  ${RESPONSE.text}
    ${JOBID}                        Set Variable                        ${RESPONSE.json()["job_id"]}
    ${JOBID}                        Get Substring                       ${JOBID}    -7
    Move File                       ${PATH}/${FILE}                     ${PROCESSED}
    Set Global Variable             ${JOBID}
    Set Global Variable             ${HEADERS}
    Set Global Variable             ${RESPONSE}


Check Job Status By Request
    [Documentation]

    ${RESPONSE}                             Get Request                             NextApi
    ...                                                                             jobs/${JOBID}
    ...                                                                             headers=${HEADERS}
    Log To Console                          Status is: ${RESPONSE.json()["job"]["status"]}
    Log To Console                          ...  
    Dictionary Should Contain Item          ${RESPONSE.json()["job"]}               status                                      ${JOB_STATUS}
    
##
## CODE FOR THE COMMAND LINE EXECUTION
##
Run Playbook By Command Line
    [Documentation]                 Run the playbook with the parameters in the txt file by a curl command line (depreciated)
    [Arguments]                     ${FILE}
    
    Generate Playbook Param        ${FILE}
    ${ENDPOINT}=                   Catenate                 SEPARATOR=/    
    ...                                                     ${URLAPI}    
    ...                                                     clients/${CLIENT}
    Log To Console                 Execution of the file ${FILE}
    Log To Console                 ...
    ${RESPONSE}                    Run                      curl -k -X POST -H "Authorization: Token token=${TOKEN}" -H "Content-Type: application/json" "${ENDPOINT}/adhoc/run/" -d \ '${ADHOCSTR}'               
    Set Global Variable            ${RESPONSE}
    Log To Console                 ${RESPONSE}
    Move File                      ${PATH}/${FILE}          ${PROCESSED}

Get JobID By Command Line
    [Documentation]          Check the response information and gets the Job ID

    ${JOBID}                 Get Substring    ${RESPONSE}    -9    -2
    Log                      ${JOBID}
    Set Global Variable      ${JOBID}

Check Job Status By Command Line
    [Documentation]         Runs a API get to test the JOB execution status

    ${EVENTLIST}            Run                curl -k -X GET -H "Authorization: Token token=${TOKEN}" -H "Content-Type: application/json" "${URLAPI}/jobs/${JOBID}"
    Log To Console          ${EVENTLIST}
    Log To Console          ...
    Should Not Contain      ${EVENTLIST}        "status":"started"

#${EVENTLIST}        Run                curl -k -X GET -H "Authorization: Token token=${TOKEN}" -H "Content-Type: application/json" "${URLAPI}/jobs/${JOBID}/job_events"

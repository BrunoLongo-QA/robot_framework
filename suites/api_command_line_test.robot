*** Settings ***
Documentation      Author: Bruno Longo
...                Version: 1.3.1
...                Description: Automation to run the PB by API using command line.
...                For the complete documentation check: https://apps.na.collabserv.com/wikis/home?lang=en-us#!/wiki/W6f3c4680e937_4592_ae2a_bd086384af9f/page/(Draft)%20Robot%20Documentation
Resource           ../source/api.resource
Suite Setup        Run Keywords         Connect To API              Get The Playbook Files 

*** Test Case ***
Running The Playbook Files By Command
    [Documentation]         Will check for every file on the directory and run the playbook
    
    FOR                             ${INDEX}                                                        IN RANGE        ${SCRIPTQTD}
    Run Playbook By Command Line    ${FILESLIST[${INDEX}]}
    Get JobID By Command Line
    Wait Until Keyword Succeeds     ${TIME}x         1.0s        Check Job Status By Command Line
    END
    
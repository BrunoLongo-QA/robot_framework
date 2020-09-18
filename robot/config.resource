# [Documentation]    Author: Bruno Longo
# ...                Version: 1.3.1

## This file is the configuration to run the Robot automation.
## Down below you have the information of what is needed to the robot runs without any problems.
## Pay attention to the lines numbers, those are important DOESN'T CHANGE THE LINES SEQUENCE.
*** Variables ***
## Down below input the API URL (remember to point to local https://local.blueops.net/tupix/api/v1 or the QA URL https://qa.blueops.net/tupix/api/v1/).
${URLAPI}         https://local.blueops.net/tupix/api/v1

## Down below inform your API token (remember that you can have a local token, a QA token and a PROD token).
${TOKEN}            46b251e30f64c816329d0a3a768ef05375f9e89aa1c7da3662ac8d3d6045791547b3d3f842e7b5acb8e02b1bb5f3d09aac1197af2562e7518a38a9085fa7729ff6a4519923026481696d0b22b6855c089912c9679e62ff299503f1714438f3c8f852727bcf414e40a052ef37e7c2f9fb44d3ecb5a216424f8b8ea5e429b5a516

## Down below inform the path to the scripts files (those are the files with the PB information such as hosts, params and playbook name).
## If you are running robot through a git repository uses the path ../robot/source or if you are running for the robot zip folder uses ../source, any way you can change the path, but pay attention because wrong paths causes errors on the execution.
${PATH}             ../robot/source/scriptToRun

## Down below inform the destination path to processed script files (../robot/source/processed)
${PROCESSED}        ../robot/source/scriptToRun

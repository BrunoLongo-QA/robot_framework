## ROBOT AUTOMATION

For use the robot automation is simple, just run/execute the RobotApplication.sh file in this directory.

In these folders you will have the Robot Automation scripts and configurations.

Any changes on the files can result in many problems for any issues, questions or new features just open a support here: https://github.ibm.com/la-innovation/qa_initiative/issues/new/choose


## DOWNLOAD

For now you can download robot from: https://ibm.ent.box.com/folder/109788028490

## CONFIGURING & RUNNING

For the right execution the best way of running this initial tests is creating the robot folder in or Documents directory.

The final path should be something like this: ~/userName/Documents/Robot

First of all, understands that this automation looks in the configuration file for the scripts path, the API end point and others information.

Down below you will have a guide to help you configurate your test scripts.

The scripts are simple's txt files with the following information and layout (this point is important, use the templates as a guide and any questions just ask @Bruno-Pereira-Longo1):

account code (Just the client code)

"playbook.yml" 
"group", "group2"
"host1", "host2"
"param_name": "param", "param_name2": "param2"
timeSeconds (This information is mandatory, if you don't know input 120)
job_end_status

This template should be followed step by step, for exemple:

**_Leave a blank space for the information that you will not use._**

"g2t"
"GEN_URL_Down.yml"

"labcentos6"
"script_path": "scripts/linux/url_down.sh", "script_params": "w3.ibm.com"
120
success

With this information robot will run the PB GEN_URL_Down for the client g2t without any group but for the host labcentos6 with the params as informed.

It is very important that you use the right template for the automation works. In the directory robot/source/scriptToRun we have two examples for you to look at. We also have "blank" files in the robot/ directory for you to copy and change if you want.

## VALIDATING

At the end of the execution a log will be created in the log directory (robot/log) with the timestemp of the execution.

The log is very simple to understand but if you have any problems just contact @Bruno-Pereira-Longo1.

|Version|Features|Status|Link|
|-------|--------|------|----|
|1.3.1| Creation of the RobotApplication.sh file to run the robot, validation on the PB execution using the new features on the API and a refactoring of all the code to make the request to the API by a Request library and not by curl command, making the execution faster, smarter and enhancing the code value.| Deployed - Up to Date|https://ibm.ent.box.com/folder/109788028490|
|1.2|First Draft version, runs the API by curl commands|Out of Date|Out of Date|

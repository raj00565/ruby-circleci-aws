#!/bin/bash

# Deploy hooks are run via absolute path, so taking dirname of this script will give us the path to
# our deploy_hooks directory.
. $(dirname $0)/common_variables.sh

apt update -y &> /dev/null
if [ $? != 0 ]; then
    apt install python3-pip -y
fi

pip3 list | grep -q ansible
if [ $? != 0 ]; then
    pip3 install ansible
fi



#ansible-playbook $DESTINATION_PATH/AnsibleScripts/site.yml -i $DESTINATION_PATH/AnsibleScripts/hosts --connection=local 

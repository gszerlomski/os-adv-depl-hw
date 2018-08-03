#!/bin/bash

while getopts g:i:e:p: option
do
case "${option}"
in
g) GUID=${OPTARG};;
i) INTERNAL=${OPTARG};;
e) EXTERNAL=${OPTARG};;
p) CURRENT_PATH=${OPTARG};;
esac
done


if [ -z $GUID ]; then GUID=`hostname|awk -F. '{print $2}'`; fi
if [ -z $INTERNAL ]; then INTERNAL=internal; fi
if [ -z $EXTERNAL ]; then EXTERNAL=example.opentlc.com; fi
if [ -z $CURRENT_PATH ]; then CURRENT_PATH=`pwd`; fi

echo -- GUID = $GUID --
echo -- Internal domain = $INTERNAL --
echo -- External domain = $EXTERNAL -- 
echo -- Current path = $CURRENT_PATH --


echo  "-- Preparing hosts file --"
cat hosts.template | sed -e "s:{GUID}:$GUID:g;s:{DOMAIN_INTERNAL}:$INTERNAL:g;s:{DOMAIN_EXTERNAL}:$EXTERNAL:g;s:{PATH}:$CURRENT_PATH:g;" > hosts

echo -- Installing atomic packages --
#yum -y install atomic-openshift-utils atomic-openshift-clients

echo -- Retrieving certificate for LDAP --
wget http://ipa.shared.example.opentlc.com/ipa/config/ca.crt -O ./ipa-ca.crt


echo -- Checking Openshift Prerequisites --
if ansible-playbook -f 20 -i ./hosts /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml ; then
    echo -- Prerequisites successful. Installing Openshift --



else
    echo -- Prerequisites failed --
fi

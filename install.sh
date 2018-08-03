#!/bin/bash

while getopts g:i:e: option
do
case "${option}"
in
g) GUID=${OPTARG};;
i) INTERNAL=${OPTARG};;
e) EXTERNAL=${OPTARG};;
esac
done


#export GUID=`hostname|awk -F. '{print $2}'`
echo -- GUID = $GUID --
echo -- Internal domain = $INTERNAL --
echo -- External domain = $EXTERNAL -- 



echo  "-- Preparing hosts file --"
cat hosts.template | sed -e "s:{GUID}:$GUID:g;s:{DOMAIN_INTERNAL}:$INTERNAL:g;s:{DOMAIN_EXTERNAL}:$EXTERNAL:g;" > hosts

echo -- Installing atomic packages --
#yum -y install atomic-openshift-utils atomic-openshift-clients


echo -- Checking Openshift Prerequisites --
if ansible-playbook -f 20 -i ./hosts /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml ; then
    echo -- Prerequisites successful. Installing Openshift --



else
    echo -- Prerequisites failed --
fi

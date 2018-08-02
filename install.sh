#!/bin/bash

export GUID=`hostname|awk -F. '{print $2}'`
echo -- Your GUID is $GUID --

echo "-- Clonging git repo --"
# git clone https://github.com/gszerlomski/os-adv-depl-hw.git

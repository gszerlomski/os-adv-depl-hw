#!/bin/bash

export GUID=`hostname|awk -F. '{print $2}'`
echo -- Your GUID is $GUID --



#!/bin/bash
MACHINENAME=$1

#Set memory and network
VBoxManage bandwidthctl $MACHINENAME add Limit-cluster1 --type disk --limit 200M


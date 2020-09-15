#!/bin/bash
MACHINENAME=$1

#Limit cpus and Memory
VBoxManage modifyvm $MACHINENAME --cpus 1

VBoxManage modifyvm $MACHINENAME --cpuexecutioncap 30

# VBoxManage modifyvm $MACHINENAME --memory 256

#Set memory and network
VBoxManage bandwidthctl $MACHINENAME add Limit-cluster1 --type disk --limit 10M



#!/bin/bash
MACHINENAME=$1

#Set memory and network
VBoxManage bandwidthctl $MACHINENAME add Limit-cluster1 --type disk --limit 200M

#created machine
# for i in $(seq 1 6);\
# do docker-machine create --driver virtualbox redis-cluster-$i;\
# done

# for i in $(seq 1 6);\
# do docker-machine stop redis-cluster-$i;\
# done

# run config virtual machine
# for i in $(seq 1 6);\
# do ./config.sh redis-cluster-$i;\
# done


# start docker machine
# for i in $(seq 1 6);\
# do docker-machine start redis-cluster-$i;\
# done

#install the redis-cluster docker images
for i in $(seq 1 6);\
do docker $(docker-machine config redis-cluster-$i) pull bobuss/redis-cluster;\
done

#Launch the redis on the instances
for i in $(seq 1 6);\
do docker $(docker-machine config redis-cluster-$i) run -d -p 6379:6379 -p 16379:16379 bobuss/redis-cluster;\
done

./redis-cli --cluster create \
$(docker-machine ip redis-cluster-1):6379 \
$(docker-machine ip redis-cluster-2):6379 \
$(docker-machine ip redis-cluster-3):6379 \
$(docker-machine ip redis-cluster-4):6379 \
$(docker-machine ip redis-cluster-5):6379 \
$(docker-machine ip redis-cluster-6):6379 \
--cluster-replicas 1
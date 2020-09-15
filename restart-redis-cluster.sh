#!/bin/bash 

# Stop all virtual machine
# for i in $(seq 1 6);\
# do docker-machine stop redis-cluster-$i;\
# done

# Start all virtual machine
for i in $(seq 1 6);\
do docker-machine start redis-cluster-$i;\
done

#install the redis-cluster docker images
for i in $(seq 1 6);\
do docker $(docker-machine config redis-cluster-$i) pull bobuss/redis-cluster;\
done

# Launch the redis on the instances
for i in $(seq 1 6);\
do docker $(docker-machine config redis-cluster-$i) run -d -p 6379:6379 -p 16379:16379 minhwalker/redis:latest;\
done

# go to the directory src 
cd redis-6.0.6/src/

# Create cluster
./redis-cli --cluster create \
$(docker-machine ip redis-cluster-1):6379 \
$(docker-machine ip redis-cluster-2):6379 \
$(docker-machine ip redis-cluster-3):6379 \
$(docker-machine ip redis-cluster-4):6379 \
$(docker-machine ip redis-cluster-5):6379 \
$(docker-machine ip redis-cluster-6):6379 \
--cluster-replicas 1

# ./redis-benchmark -h 192.168.99.114 -c 200 -d 30000 -n 1000000 -r 100000 -t set -l -P 20 --cluster

# for i in $(seq 1 1000);\
# do ./redis-cli -h 192.168.99.114 get foo$i; \
# done


# for i in $(seq 1 1000);\
# do ./redis-cli -h 192.168.99.114 set foo$i hello$i; \
# done
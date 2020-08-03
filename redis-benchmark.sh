#!/bin/bash

# Created machine
for i in $(seq 1 6);\
do docker-machine create --driver virtualbox redis-cluster-$i;\
done

# Stop all virtual machine
for i in $(seq 1 6);\
do docker-machine stop redis-cluster-$i;\
done

# Config limit bandwidth
for i in $(seq 1 6);\
do ./config.sh redis-cluster-$i;\
done

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
do docker $(docker-machine config redis-cluster-$i) run -d -p 6379:6379 -p 16379:16379 bobuss/redis-cluster;\
done

# Pull redis:lastest version
wget http://download.redis.io/releases/redis-6.0.6.tar.gz
tar xzf redis-6.0.6.tar.gz
cd redis-6.0.6
make
cd ..

# go to the directory src 
cd redis-6.0.6/src/

# Config AOF all
echo "Benchmark with master and slave using AOF persistance config\n"
../../aof-all-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config RDB all
echo "Benchmark with master and slave using RDB persistance config\n"
../../rdb-all-config.sh 

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config none persistance 
echo "Benchmark with master and slave using none persistance config\n"
../../non-persis-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config master RDB slave AOF
echo "Benchmark with master using RDB and slave using AOF persistance config\n"
../../master_rdb-slave_aof-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config master RDB slave none
echo "Benchmark with master using RDB and slave using none persistance config\n"
../../master_rdb-slave_none-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config master AOF slave RDB
echo "Benchmark with master using AOF and slave using RDB persistance config\n"
../../master_aof-slave_rdb-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config master AOF slave none
echo "Benchmark with master using AOF and slave using none persistance config\n"
../../master_aof-slave_none-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config master none slave AOF
echo "Benchmark with master using none and slave using AOF persistance config\n"
../../master_none-slave_aof-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"

# Config master none slave RDB
echo "Benchmark with master using none and slave using RDB persistance config\n"
../../master_none-slave_rdb-config.sh

echo "\nSetup for benchmark testing:\n2.6 GHz 6-Core Intel Core i7\n1024MB Ram\nLimit Disk IO Speed: 200MB/s\n"
echo "Client:\nTotal number of request: 2000000\nKey space: 100000\nPineline: 16\n"
echo "Request type: GET, SET, LPUSH, LPOP\n"
./redis-benchmark -h $(docker-machine ip redis-cluster-1) -r 100000 -n 2000000 -t get,set,lpush,lpop -P 16 --cluster
echo "\n---------------------------------------------\n"
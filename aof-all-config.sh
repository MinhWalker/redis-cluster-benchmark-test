#!/bin/bash
./redis-cli -h $(docker-machine ip redis-cluster-1) -p 6379 config set appendonly "yes"
./redis-cli -h $(docker-machine ip redis-cluster-2) -p 6379 config set appendonly "yes"
./redis-cli -h $(docker-machine ip redis-cluster-3) -p 6379 config set appendonly "yes"
./redis-cli -h $(docker-machine ip redis-cluster-4) -p 6379 config set appendonly "yes"
./redis-cli -h $(docker-machine ip redis-cluster-5) -p 6379 config set appendonly "yes"
./redis-cli -h $(docker-machine ip redis-cluster-6) -p 6379 config set appendonly "yes"
./redis-cli -h $(docker-machine ip redis-cluster-1) -p 6379 config set save ""
./redis-cli -h $(docker-machine ip redis-cluster-2) -p 6379 config set save ""
./redis-cli -h $(docker-machine ip redis-cluster-3) -p 6379 config set save ""
./redis-cli -h $(docker-machine ip redis-cluster-4) -p 6379 config set save ""
./redis-cli -h $(docker-machine ip redis-cluster-5) -p 6379 config set save ""
./redis-cli -h $(docker-machine ip redis-cluster-6) -p 6379 config set save ""
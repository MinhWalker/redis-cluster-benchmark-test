# Redis-cluster with docker-machine benchmark test

## Description

Tool test benchmark for [redis-cluster](https://redis.io/topics/cluster-tutorial). I'm setup cluster with 3 master node and 1 slave node for per master. Provide resources for each node: 100% one core, 1024 Mb RAM, limit disk IO speed 200mb/s (you can modify this number in config.sh file). 

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker-machine](https://github.com/docker/machine)
- [redis](https://redis.io/download)
- [virtualBox](https://www.virtualbox.org/)

## Setup 

Clone project from github

```shell
$ clone https://github.com/MinhWalker/redis-cluster-benchmark-test
```

Run with command

```shell
./redis-benchmark.sh
```

## Case test

### Number of request: 2000000 , Key space: 100000, Pineline: 16 

- Master and slave using AOF persistance 
- Master and slave using RDB persistance
- Master and slave using none persistance
- Master using RDB and slave using AOF persistance
- Master using RDB and slave using none persistance
- Master using AOF and slave using RDB persistance
- Master using AOF and slave using none persistance
- Master using none and slave using AOF persistance
- Master using none and slave using RDB persistance

> __Important:__ You can custom case test on redis-benchmark.sh file.  

## Ouput 

Output example

```
Cluster has 3 master nodes:

Master 0: e87c1aa7e5e274679eb0a11a0ecc8ddd97be764d 192.168.99.123:6379
Master 1: ce349425bec15d337adaf11a58012136de7caa56 192.168.99.124:6379
Master 2: 64aabc723f0b6a379a1866eea6fc8c20c40af32c 192.168.99.122:6379

====== SET ======
  1000032 requests completed in 2.14 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  cluster mode: yes (3 masters)
  node [0] configuration:
    save: NONE
    appendonly: yes
  node [1] configuration:
    save: NONE
    appendonly: yes
  node [2] configuration:
    save: NONE
    appendonly: yes
  multi-thread: yes
  threads: 3

0.00% <= 0.8 milliseconds
0.00% <= 0.9 milliseconds
0.00% <= 1.0 milliseconds
0.03% <= 1.1 milliseconds
0.56% <= 1.2 milliseconds
3.37% <= 1.3 milliseconds
10.70% <= 1.4 milliseconds
23.75% <= 1.5 milliseconds
41.37% <= 1.6 milliseconds
59.20% <= 1.7 milliseconds
73.64% <= 1.8 milliseconds
83.76% <= 1.9 milliseconds
90.10% <= 2 milliseconds
99.21% <= 3 milliseconds
99.73% <= 4 milliseconds
99.84% <= 5 milliseconds
99.89% <= 6 milliseconds
99.92% <= 7 milliseconds
99.99% <= 8 milliseconds
100.00% <= 8 milliseconds
466432.81 requests per second

====== GET ======
  1000032 requests completed in 1.65 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  cluster mode: yes (3 masters)
  node [0] configuration:
    save: NONE
    appendonly: yes
  node [1] configuration:
    save: NONE
    appendonly: yes
  node [2] configuration:
    save: NONE
    appendonly: yes
  multi-thread: yes
  threads: 3

6.90% <= 1 milliseconds
96.91% <= 2 milliseconds
99.95% <= 3 milliseconds
100.00% <= 4 milliseconds
100.00% <= 4 milliseconds

606447.50 requests per second

```



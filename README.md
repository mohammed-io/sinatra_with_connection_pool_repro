# Readme

## Setup

### Install Dependencies
`bundle install`

### Install Postgres

You need to install postgres server with a password-less connection with the default username.

### Install `wrk`

`brew install wrk`

## Start Server

`./serve.sh`

## Run Benchmark

`./benchmark.sh`


## Benchmark Result for Pool of 20 connections

```
Running 10s test @ http://localhost:4040
  1 threads and 32 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.48s   493.00ms   2.00s    52.57%
    Req/Sec    31.08     38.25   148.00     91.67%
  200 requests in 10.10s, 40.82KB read
  Socket errors: connect 0, read 0, write 0, timeout 25
Requests/sec:     19.81
Transfer/sec:      4.04KB
```

**NOTE:** The req/s number will fluctuate, ±1 req/s

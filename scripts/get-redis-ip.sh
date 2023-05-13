#!/bin/bash

# Obtain the IP address of the Redis Master container
ip_address=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-master)

# Create the sentinel.conf file
cat > ../sentinel.conf << EOF
sentinel monitor mymaster $ip_address 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 10000
sentinel parallel-syncs mymaster 1
EOF

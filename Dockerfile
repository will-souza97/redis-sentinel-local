# Build the RedisJSON module
FROM redislabs/rejson:2.6.0 as redisjson

# Build the RediSearch module
FROM redislabs/redisearch:2.8.0 as redisearch

# Build the Redis
FROM redis:latest as redis

WORKDIR /usr/lib/redis/modules

COPY --from=redisjson /usr/lib/redis/modules/rejson.so .
COPY --from=redisearch /usr/lib/redis/modules/redisearch.so .

CMD ["redis-server", "--loadmodule", "/usr/lib/redis/modules/rejson.so", "--loadmodule", "/usr/lib/redis/modules/redisearch.so"]

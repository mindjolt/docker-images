#!/bin/bash

/entrypoint.sh couchbase-server &

check_db() {
  curl --silent http://127.0.0.1:8091/pools > /dev/null
  echo $?
}

until [[ $(check_db) = 0 ]]; do
  sleep 1
done

sleep 15
echo Restoring data

cbrestore -t 4 -u gs -p admin123 -b jcl -B admin-new /backup/data/ http://localhost:8091

sleep 10



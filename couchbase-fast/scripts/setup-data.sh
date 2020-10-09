#!/bin/bash

cd `dirname $0` 

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

cbrestore -x data_only=1 -vv -t 4 -u gs -p admin123 -b jcl -B admin-new /backup/data/ http://localhost:8091

sleep 10

cbq -e http://localhost:8093 -u gs -p admin123 -f=./scrub.sql

sleep 10

couchbase-cli bucket-edit -u gs -p admin123 -c localhost --bucket-ramsize=100 --bucket=gs
couchbase-cli bucket-edit -u gs -p admin123 -c localhost --bucket-ramsize=100 --bucket=edms
couchbase-cli bucket-edit -u gs -p admin123 -c localhost --bucket-ramsize=100 --bucket=data
couchbase-cli bucket-edit -u gs -p admin123 -c localhost --bucket-ramsize=512 --bucket=admin-new

couchbase-cli bucket-compact -u gs -p admin123 -c localhost --bucket=gs
couchbase-cli bucket-compact -u gs -p admin123 -c localhost --bucket=edms
couchbase-cli bucket-compact -u gs -p admin123 -c localhost --bucket=data
couchbase-cli bucket-compact -u gs -p admin123 -c localhost --bucket=admin-new
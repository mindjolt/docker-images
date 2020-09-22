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

cbrestore -x data_only=1 -vv -t 4 -u gs -p admin123 -b jcl -B admin-new /backup/data/ http://localhost:8091

sleep 10

cbq -e http://localhost:8093 -u gs -p admin123 -s "update \`admin-new\` set jclConfigUrl='http://config:7002/v1' where meta().id like 'game:%' and jclConfigUrl is not null;"


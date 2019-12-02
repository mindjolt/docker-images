#!/bin/bash

/entrypoint.sh couchbase-server &

check_db() {
  curl --silent http://127.0.0.1:8091/pools > /dev/null
  echo $?
}

until [[ $(check_db) = 0 ]]; do
  sleep 1
done

couchbase-cli cluster-init --cluster-username=gs --cluster-password=admin123 --cluster-port=8091 --cluster-ramsize=1024 --cluster-index-ramsize=1024 --services=data,index,query

couchbase-cli bucket-create -c localhost --bucket=gs --bucket-type=couchbase --bucket-ramsize=512 -u gs -p admin123
couchbase-cli bucket-create -c localhost --bucket=edms --bucket-type=couchbase --bucket-ramsize=256 -u gs -p admin123
couchbase-cli bucket-create -c localhost --bucket=admin-new --bucket-type=couchbase --bucket-ramsize=256 -u gs -p admin123

sleep 10

cbq -e http://localhost:8093 -u gs -p admin123 -s "CREATE PRIMARY INDEX ON \`gs\`;"
cbq -e http://localhost:8093 -u gs -p admin123 -s "CREATE PRIMARY INDEX ON \`edms\`;"
cbq -e http://localhost:8093 -u gs -p admin123 -s "CREATE PRIMARY INDEX ON \`admin-new\`;"

sleep 5

couchbase-cli user-manage -c localhost -u gs -p admin123 --set --rbac-username gs --rbac-password admin123 --roles admin --auth-domain local
couchbase-cli user-manage -c localhost -u gs -p admin123 --set --rbac-username edms --rbac-password admin123 --roles admin --auth-domain local
couchbase-cli user-manage -c localhost -u gs -p admin123 --set --rbac-username admin-new --rbac-password admin123 --roles admin --auth-domain local

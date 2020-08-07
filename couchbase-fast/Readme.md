# Couchbase-fast

## Building couchbase-fast

To build the basic couchbase-fast image with no data simply run:

```bash
docker build --no-cache -t sgn0/couchbase-fast .
```

## Notes for adding data

### Existing data volume

If you are starting from an existing data volume, first extract the data using the following:

```bash
docker run -ti --rm \
  -v gs-docker_cb-data:/data \
  -v `pwd`/data:/backup \
  ubuntu tar -zcvf /backup/data.tar.gz /data
```

This will set the data into `./data/data.tar.gz`. Now you can run the following to create the image:

```bash
docker build --no-cache -t sgn0/couchbase-fast:dev-data -f ./Dockerfile-data .
```

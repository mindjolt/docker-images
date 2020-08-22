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
  -v gs-containerization_cb-data:/data \
  -v `pwd`/data:/backup \
  ubuntu tar -zcvf /backup/data.tar.gz /data
```

This will set the data into `./data/data.tar.gz`. Now you can run the following to create the image:

```bash
docker build --no-cache -t sgn0/couchbase-fast:dev-data -f ./Dockerfile-data .
```

### Stage backup

When using a backup from stage, you can run the following the load the data to an image:

```bash
# copy data to data directory
cp ~/Downloads/2020-08-14T070001Z.tgz ./data/backup.tgz

docker build --squash --no-cache -t sgn0/couchbase-fast:dev-stagedata -f ./Dockerfile-restore .
```

The data can be downloaded from the following S3 Bucket: `jc-staging-couchbase`


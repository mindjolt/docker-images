FROM openjdk:8-jdk

LABEL maintainer="Paul Ashdown, paul@jamcity.com"

RUN mkdir /var/dynamodb_local

WORKDIR /var/dynamodb_local

VOLUME ["/dynamodb_local_db"]

ENV DYNAMODB_VERSION=latest
#ENV DYNAMODB_VERSION=1.11.477

ENV DYNAMODB_PORT=8000

ENV JAVA_OPTS=

RUN curl -sL -O https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_${DYNAMODB_VERSION}.tar.gz && \
    curl -sL -O https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_${DYNAMODB_VERSION}.tar.gz.sha256 && \
    tar zxvf dynamodb_local_${DYNAMODB_VERSION}.tar.gz && \
    rm dynamodb_local_${DYNAMODB_VERSION}.tar.gz dynamodb_local_${DYNAMODB_VERSION}.tar.gz.sha256

COPY log4j2.xml /var/dynamodb_local

RUN touch log4j2.xml && \
    jar -uf DynamoDBLocal.jar log4j2.xml && \
    rm log4j2.xml

COPY ./docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000

CMD ["--sharedDb", "-dbPath", "/dynamodb_local_db"]

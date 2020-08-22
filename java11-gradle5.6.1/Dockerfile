FROM openjdk:11.0.4-jdk-slim-buster

COPY gradle /gradle
COPY gradlew /

RUN /gradlew -h > /dev/null && \
  rm /gradlew && \
  rm -rf /gradle && \
  rm /root/.gradle/wrapper/dists/gradle-5.6.1-bin/bycvpp2xqg8wbfxm5cc0t3675/gradle-5.6.1-bin.zip
ENV PATH=/root/.gradle/wrapper/dists/gradle-5.6.1-bin/bycvpp2xqg8wbfxm5cc0t3675/gradle-5.6.1/bin:/usr/local/openjdk-11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

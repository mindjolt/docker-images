FROM sgn0/java14

COPY gradle /gradle
COPY gradlew /

RUN /gradlew -h > /dev/null && \
  rm /gradlew && \
  rm -rf /gradle && \
  rm /root/.gradle/wrapper/dists/gradle-6.3-bin/8tpu6egwsccjzp10c1jckl0rx/gradle-6.3-bin.zip && \
  ln -s /root/.gradle/wrapper/dists/gradle-6.3-bin/8tpu6egwsccjzp10c1jckl0rx/gradle-6.3/bin/gradle /usr/bin/gradle
ENV PATH=/root/.gradle/wrapper/dists/gradle-6.3-bin/8tpu6egwsccjzp10c1jckl0rx/gradle-6.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

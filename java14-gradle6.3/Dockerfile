FROM sgn0/java14

COPY gradle /gradle
COPY gradlew /

RUN /gradlew -h > /dev/null && \
  rm /gradlew && \
  rm -rf /gradle && \
  rm /root/.gradle/wrapper/dists/gradle-6.3-all/b4awcolw9l59x95tu1obfh9i8/*.zip && \
  ln -s /root/.gradle/wrapper/dists/gradle-6.3-all/b4awcolw9l59x95tu1obfh9i8/gradle-6.3/bin/gradle /usr/bin/gradle
ENV PATH=/root/.gradle/wrapper/dists/gradle-6.3-all/b4awcolw9l59x95tu1obfh9i8/gradle-6.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

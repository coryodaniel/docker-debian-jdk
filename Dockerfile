FROM debian:9.4-slim
MAINTAINER Cory ODaniel "docker@coryodaniel.com"

ENV JAVA_HOME "/usr/lib/jvm/java-9-openjdk-amd64/bin/java"

RUN mkdir -p /usr/share/man/man1 \
    && echo "deb http://http.debian.net/debian stretch-backports main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends -t stretch-backports openjdk-9-jdk \
    && apt-get clean

CMD ["java", "--version"]

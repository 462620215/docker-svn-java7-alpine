FROM alpine:latest
MAINTAINER kingsy <kingsylin@vip.qq.com>

RUN apk update && apk add openjdk7 wget bash subversion unzip

RUN sed -i 's/\/dev\/urandom/\/dev\/.\/urandom/g' /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/java.security

WORKDIR /work

RUN wget http://apache.mesi.com.ar/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip >/dev/null 2>&1\
    && unzip apache-maven*.zip && rm -f apache-maven*.zip && mv apache-maven* maven

COPY ./settings.xml /root/.m2/

COPY ./docker-entrypoint.sh /

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]

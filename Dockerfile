FROM ubuntu:latest AS builder
RUN apt update -y && \
    apt install -y openjdk-8-jdk && \
    apt install -y maven
COPY . .
RUN mvn -DskipTests package

FROM openjdk:8-alpine
WORKDIR /usr/src/app
#COPY ./target/*.jar ./app.jar
COPY --from=builder ./target/*.jar ./app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/urandom","-jar","./app.jar", "--port=80"]

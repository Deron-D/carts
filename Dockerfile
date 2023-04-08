FROM openjdk:8-alpine

WORKDIR /usr/src/app
COPY /home/dpp/Документы/Otus/sockshop/src/carts/target/*.jar ./app.jar


ENTRYPOINT ["java","-Djava.security.egd=file:/dev/urandom","-jar","./app.jar", "--port=80"]

FROM maven:3.6-jdk-11 AS builder
COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven
RUN mvn -q -DskipTests package

FROM weaveworksdemos/msd-java:jre-latest

WORKDIR /usr/src/app
COPY --from=builder /usr/src/mymaven/target/*.jar ./app.jar

RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG COMMIT

LABEL org.label-schema.vendor="Weaveworks" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.version="${BUILD_VERSION}" \
  org.label-schema.name="Socks Shop: Cart" \
  org.label-schema.description="REST API for Cart service" \
  org.label-schema.url="https://github.com/Deron-D/carts" \
  org.label-schema.vcs-url="github.com:Deron-D/carts.git" \
  org.label-schema.vcs-ref="${COMMIT}" \
  org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/local/bin/java.sh","-jar","./app.jar", "--port=80"]

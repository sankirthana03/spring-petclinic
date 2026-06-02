FROM maven:4.0.0-rc-5-eclipse-temurin-25-alpine AS build
ADD . /app
WORKDIR /app
RUN mvn package

FROM eclipse-temurin:25-noble AS runtime
ENV project=prod
ENV JAVA_HOME=/usr/lib/jvm/openjdk-17-jdk-amd64
ENV MAVEN_HOME=/opt/
ARG myownuser=sankirthana
ARG homedir=/devops
RUN useradd -m -d ${homedir} -s /bin/bash ${myownuser}
USER ${myownuser}
WORKDIR /devops
COPY --from=build /app/target/*.jar lion.jar
EXPOSE 8080
CMD ["java", "-jar", "lion.jar"]

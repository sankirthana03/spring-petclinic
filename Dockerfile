FROM maven:4.0.0-rc-5-eclipse-temurin-25-alpine AS build
ADD . /app
WORKDIR /app
RUN mvn package

FROM eclipse-temurin:25-noble AS runtime
RUN useradd -m -d /devops -s /bin/bash sankirthana
USER sankirthana
WORKDIR /devops
COPY --from=build /app/target/*.jar lion.jar
EXPOSE 8080
CMD ["java", "-jar", "lion.jar"]

FROM eclipse-temurin:17-jdk AS build

COPY pom.xml mvnw ./
COPY .mvn .mvn
RUN ./mvnw dependency:resolve

COPY src src
RUN ./mvnw package

# Crear una nueva imagen basada en OpenJDK 17
FROM eclipse-temurin:17-jdk

WORKDIR demo
COPY --from=build target/*.jar demo.jar
ENTRYPOINT ["java", "-jar", "demo.jar"]
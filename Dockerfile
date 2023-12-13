FROM eclipse-temurin:17-jdk AS build
COPY . .
RUN ./mvnw dependency:resolve
RUN ./mvnw package

# Crear una nueva imagen basada en OpenJDK 17
FROM eclipse-temurin:17-jdk
EXPOSE 8080
COPY --from=build target/spring-deploy-1.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

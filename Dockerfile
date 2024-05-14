# Use the official OpenJDK image as the base
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

EXPOSE 8081


ENTRYPOINT ["java", "-jar", "demo.jar"]

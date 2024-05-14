# Use the official OpenJDK image as the base
FROM openjdk:21-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the compiled JAR file into the container
COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose the port on which the Spring Boot application will listen
EXPOSE 8081

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "demo.jar"]

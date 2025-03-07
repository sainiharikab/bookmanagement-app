# Stage 1: Build the project
  FROM maven:3.9.9-eclipse-temurin-17 AS build

# Set the working directory in the container
 WORKDIR /app


# Copy the pom.xml and source code
COPY . .


# Build the Maven project
RUN mvn clean install

# Stage 2: Run the project
FROM openjdk:17-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar /app/bookmanagement-app.jar

# Expose the port the app runs on
EXPOSE 8081

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/bookmanagement-app.jar"]

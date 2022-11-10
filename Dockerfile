# FROM maven:3.8.6-jdk-11 as Build
# WORKDIR /simple-java-maven-app
# COPY /src ./src
# COPY /pom.xml /pom.xml
# RUN mvn clean install

FROM openjdk
WORKDIR /My-app
COPY ./target/my-app-*.jar ./my-app.jar
CMD ["java", "-jar", "./my-app.jar"]

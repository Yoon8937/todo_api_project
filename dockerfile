FROM maven:3.9.11-eclipse-temurin-11 AS build
WORKDIR /app/todo_api_project

COPY pom.xml .

RUN --mount=type=cache,target=/root/.m2 \
    mvn -B dependency:go-offline 
#RUN mvn -B dependency:go-offline

#RUN ls /root/.m2 # No such file or directory

#RUN --mount=type=cache,target=/root/.m2 \
#    ls -al /root/.m2/repository
#RUN find /root/.m2/repository -maxdepth 2 -type d | head -50

COPY src ./src

RUN --mount=type=cache,target=/root/.m2 \
    mvn package




FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/todo_api_project/target/*.jar todo.jar

EXPOSE 8080
CMD ["java", "-jar", "todo.jar"]
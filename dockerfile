FROM maven:3.9.11-eclipse-temurin-11 AS build
WORKDIR /app/todo_api_project

COPY pom.xml .

# 이 경로와 yml파일에서 경로도 맞춰줘야 되는 것 같음. 그래서 캐시를 활용할 수 있음.
RUN --mount=type=cache,target=/root/.m2/repository \
    mvn -B dependency:go-offline
#RUN mvn -B dependency:go-offline
Run ls -al /root/

#RUN ls /root/.m2 # No such file or directory

#RUN --mount=type=cache,target=/root/.m2 \
#    ls -al /root/.m2/repository
#RUN find /root/.m2/repository -maxdepth 2 -type d | head -50

COPY src ./src

RUN --mount=type=cache,target=/root/.m2/repository \
    mvn package




FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/todo_api_project/target/*.jar todo.jar

EXPOSE 8080
CMD ["java", "-jar", "todo.jar"]
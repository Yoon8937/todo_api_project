FROM maven:3.9.11-eclipse-temurin-11 AS build
#WORKDIR /app

WORKDIR /app/todo_api_project

COPY pom.xml .

#RUN --mount=type=cache,target=/root/.m2 \
#    mvn -B dependency:go-offline 
RUN mvn -B dependency:go-offline

#COPY . /app/todo_api_project
#COPY src /app/todo_api_project

#COPY src .  # 폴더 안에 있는 내용물(예: main, test 폴더 등)이 바로 아래에 풀림
COPY src ./src

#WORKDIR /app/todo_api_project
RUN mvn package


FROM eclipse-temurin:11-jre

WORKDIR /app

COPY --from=build /app/todo_api_project/target/*.jar todo.jar 


EXPOSE 8080
CMD ["java", "-jar", "todo.jar"] 

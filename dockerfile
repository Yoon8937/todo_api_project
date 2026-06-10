#FROM maven:3.9.11-eclipse-temurin-11 AS build
#WORKDIR /app

###COPY todo_api_project /app/todo_api_project #couldn't find path
#COPY . /app/todo_api_project

#WORKDIR /app/todo_api_project

#RUN mvn clean package




FROM eclipse-temurin:11-jre

WORKDIR /app

#COPY --from=build /app/todo_api_project/target/*.jar todo.jar 
COPY ./target/*.jar todo.jar

EXPOSE 8080
CMD ["java", "-jar", "todo.jar"] 

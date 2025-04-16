# Etapa 1: construir el proyecto
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

# Copia el proyecto completo
COPY . .

# Construye el proyecto y empaqueta el .jar
RUN mvn clean package -DskipTests

# Etapa 2: imagen ligera para ejecutar el .jar
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copiamos el jar desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Expone el puerto de la app
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["java", "-jar", "app.jar"]

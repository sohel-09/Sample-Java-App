FROM openjdk:17
COPY helloworld.java /app/
WORKDIR /app
RUN javac helloworld.java
CMD ["java", "helloworld"]

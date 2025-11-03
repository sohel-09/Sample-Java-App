# FROM openjdk:17-jdk-slim

 
# COPY HelloWorld.java .
# RUN javac HelloWorld.java
 
# CMD java HelloWorld && tail -f /dev/null

FROM openjdk:17-jdk-slim
WORKDIR /app

COPY HelloWorld.java .
RUN javac HelloWorld.java

# Run the app and keep it alive if needed
CMD ["java", "HelloWorld"]


# FROM openjdk:17-jdk-slim

 
# COPY HelloWorld.java .
# RUN javac HelloWorld.java
 
# CMD java HelloWorld && tail -f /dev/null

# FROM openjdk:17-jdk-slim
# WORKDIR /app

# COPY HelloWorld.java .
# RUN javac HelloWorld.java

# # Run the app and keep it alive if needed
# CMD ["java", "HelloWorld"]

FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy and compile
COPY HelloWorld.java .
RUN javac HelloWorld.java

# Run and keep container alive (so GKE can stream logs)
CMD ["bash", "-c", "java HelloWorld && sleep infinity"]



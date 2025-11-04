FROM openjdk:17-jdk-slim
WORKDIR /app

COPY HelloWorld.java .
RUN javac HelloWorld.java

# Run and keep container alive ((so GKE can stream logs))
CMD ["bash", "-c", "java HelloWorld && sleep infinity"]



# Sentinel Dashboard Image 1.8.6
# Dockerfile reference: https://docs.docker.com/engine/reference/builder/

# openjdk镜像官网显示此镜像已经废弃，让选择其他替代品
FROM eclipse-temurin:8-jdk-alpine

LABEL author=kwseeker

RUN mkdir -p /home/sentinel

WORKDIR /home/sentinel

ADD https://github.com/alibaba/Sentinel/releases/download/1.8.6/sentinel-dashboard-1.8.6.jar sentinel-dashboard.jar
# COPY sentinel-dashboard-1.8.6.jar sentinel-dashboard.jar

ENV JAVA_OPTS=" -Xms128M "

# sentinel dashboard 默认端口 8080, Sentinel Dashboard 可能还有其他一些可配置的东西后面再看
EXPOSE 8080

COPY docker-entrypoint.sh .

ENTRYPOINT ["bash", "docker-entrypoint.sh"]
# ENTRYPOINT ["java","-jar","sentinel-dashboard-1.8.0.jar"]

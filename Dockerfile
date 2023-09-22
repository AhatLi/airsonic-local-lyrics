FROM ubuntu:20.04

ENV TZ=Asia/Seoul

RUN apt-get update && \
    apt-get install -y ca-certificates ffmpeg flac fontconfig lame openjdk-8-jre ttf-dejavu wget && \
    apt-get clean

RUN mkdir /opt/tomcat && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz -O /tmp/tomcat.tar.gz && \
    tar xzvf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz

COPY airsonic-main/target/airsonic.war /opt/tomcat/webapps/

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

EXPOSE 8080
VOLUME /media /var/airsonic

# docker build -t airsonic-local-lyric:1 .
#
# docker run -d --name=airsonic -e TZ=asia/seoul -p 8080:8080 -v /root/airsonic:/var/airsonic   -v /root/airsonic/media:/media  --restart unless-stopped  airsonic-local-lyric:1
FROM opensuse/leap:15.3
MAINTAINER madhuri.devidi@sap.com
RUN zypper --non-interactive install wget tar gzip hostname vim curl

#RUN zypper --non-interactive install wget
RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.88/bin/apache-tomcat-8.5.88.tar.gz
RUN tar xvfz apache-tomcat-8.5.88.tar.gz
RUN mv apache-tomcat-8.5.88/* /opt/tomcat/.
#RUN yum -y install java
RUN wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
RUN sudo rpm -ivh jdk-17_linux-x64_bin.rpm
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war

ENV DOCKER_HOST="tcp://docker:2376/"
ENV DOCKER_TLS_CERTDIR="/certs"
ENV DOCKER_TLS_VERIFY=1
ENV DOCKER_CERT_PATH="$DOCKER_TLS_CERTDIR/client"

EXPOSE 9080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

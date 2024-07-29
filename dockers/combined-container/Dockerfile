FROM ubuntu:latest

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    gnupg \
    lsb-release \
    python3 \
    python3-pip \
    postgresql \
    postgresql-contrib \
    tomcat9 \
    tomcat9-admin \
    tomcat9-common \
    tomcat9-user \
    && apt-get clean

# Setup PostgreSQL
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE USER user WITH PASSWORD 'password';" && \
    sudo -u postgres psql -c "CREATE DATABASE mydatabase OWNER user;"

# Setup Tomcat
COPY webapps /var/lib/tomcat9/webapps

# Install Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - && \
    sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && \
    apt-get update && apt-get install -y jenkins

# Configure services to start
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 8080 8081 5432 50000

ENTRYPOINT ["/startup.sh"]

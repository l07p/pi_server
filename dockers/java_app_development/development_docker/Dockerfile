# Use an official Java image as the base
FROM openjdk:11-jdk

# Install Node.js and Angular CLI
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @angular/cli

# Install Vim
RUN apt-get update && apt-get install -y vim

# Set the working directory in the container
WORKDIR /usr/src/app

# Expose necessary ports (example: Angular port and Tomcat port)
EXPOSE 4200 8080

# Specify the command to keep the container running
CMD ["tail", "-f", "/dev/null"]

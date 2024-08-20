# Use a base image with Java, Node.js, and npm
FROM openjdk:11-jdk-slim

# Install Node.js and npm
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    git \
    && npm install -g @angular/cli

# Set the working directory inside the container
WORKDIR /usr/src/app

# Expose port for Angular development server
EXPOSE 4200

# Command to keep the container running
CMD ["tail", "-f", "/dev/null"]

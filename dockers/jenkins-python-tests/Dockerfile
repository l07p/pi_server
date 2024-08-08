# Use the official Jenkins LTS image as the base
FROM jenkins/jenkins:lts

# Switch to root user to install additional packages
USER root

# Install Python 3 and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Install pytest
RUN pip3 install pytest

# Install JUnit (JUnit itself is a framework and does not need installation, 
# but ensuring we have Java installed which is required by Jenkins to process JUnit XML reports)
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt-get clean

# Switch back to the jenkins user
USER jenkins

# Define default command
CMD ["jenkins.sh"]

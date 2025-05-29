FROM jenkins/jenkins:lts

USER root

# Install Docker using the official Docker installation script
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://get.docker.com | sh

# Add the Jenkins user to the Docker group
RUN usermod -aG docker jenkins

USER jenkins


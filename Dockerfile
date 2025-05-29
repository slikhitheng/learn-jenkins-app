FROM jenkins/jenkins:lts

# Switch to root to install necessary packages
USER root

# Update package lists and install dependencies
RUN apt-get update && \
    apt-get install -y docker.io curl libvips-dev && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for global npm installations and set appropriate permissions
RUN mkdir -p /var/jenkins_home/.npm-global && \
    chown -R jenkins:jenkins /var/jenkins_home/.npm-global

# Switch back to the jenkins user
USER jenkins
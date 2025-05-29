FROM jenkins/jenkins:lts
USER root
RUN apt-get update && \
    apt-get install -y docker.io curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs | apt-get install -y libvips-dev
USER jenkins
RUN mkdir -p /var/jenkins_home/.npm-global && \
    npm config set prefix '/var/jenkins_home/.npm-global' && \
    npm config set cache '/var/jenkins_home/.npm-global/_cache'
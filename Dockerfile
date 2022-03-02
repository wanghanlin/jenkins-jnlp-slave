FROM jenkins/jnlp-slave:latest
# FROM jenkinsci/jnlp-slave:3.27-1

USER root

RUN curl --silent --location https://deb.nodesource.com/setup_16.x | bash -

RUN curl -sSL https://get.docker.com/ | sh

RUN usermod -a -G docker jenkins

RUN apt-get update && apt-get install python-pip -y

RUN pip install awscli
    
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN apt-get update && \
    apt-get install build-essential nodejs -y && \
    npm install --global yarn && \
    npm install --global --unsafe-perm node-sass 

USER jenkins

RUN mkdir -p /home/jenkins/.ssh

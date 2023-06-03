# FIXME use a less chubby base image
FROM ubuntu:22.04

# Install Dependencies
# FIXME explicitely define version to maximise stability
# TODO it'd be really great if we can combine all of these into a single Docker layer
RUN ["apt", "update"]
RUN ["apt", "install", "-y", "python3"]
RUN ["apt", "install", "-y", "python3-pip"]
RUN ["apt", "install", "-y", "nodejs"]

RUN ["apt", "install", "-y", "git"]
RUN ["apt", "install", "-y", "graphviz"]

## Installation of the AWS CLI v2
RUN ["apt", "install", "-y", "curl"]
RUN ["apt", "install", "-y", "unzip"]
RUN ["curl", "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip", "-o", "awscliv2.zip"]
RUN ["unzip", "awscliv2.zip"]
RUN ["chmod", "+x", "./aws/install"]
RUN ["./aws/install"] 

WORKDIR /actions

# Retrieve and Install Terravision Project
RUN ["git", "clone", "https://github.com/patrickchugh/terravision.git"]
RUN ["git", "-C", "./terravision", "checkout", "b8ac1244bb754fb6cdfb0dcfcbd1453dd6ba23a6"]
RUN ["pip", "install", "-r", "./terravision/requirements.txt"]
ENV PATH=${PATH}:/actions/terravision

COPY entrypoint.sh entrypoint.sh

RUN ["chmod", "+x", "entrypoint.sh"]

# Absolute path has to be specified as GHA will override the current working directory during container runtime
ENTRYPOINT ["/actions/entrypoint.sh"]
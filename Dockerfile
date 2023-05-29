# FIXME use a less chubby base image
FROM ubuntu:22.04

# Install Dependencies
# FIXME explicitely define version to maximise stability
RUN ["apt", "update"]
RUN ["apt", "install", "-y", "python3"]
RUN ["apt", "install", "-y", "python3-pip"]
RUN ["apt", "install", "-y", "nodejs"]

RUN ["apt", "install", "-y", "git"]
RUN ["apt", "install", "-y", "graphviz"]

WORKDIR /actions

# Retrieve Terravision Project
# FIXME ideally should reference a build artifact from this repo instead
RUN ["git", "clone", "https://github.com/patrickchugh/terravision.git"]
RUN ["pip", "install", "-r", "./terravision/requirements.txt"]

COPY entrypoint.sh entrypoint.sh

RUN ["chmod", "+x", "entrypoint.sh"]
ENTRYPOINT [ "./entrypoint.sh" ]
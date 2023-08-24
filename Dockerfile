FROM ubuntu:jammy AS base
ARG TAGS
ENV DEBIAN_FRONTEND=noninteractive
#RUN apt-get update && apt-get install -y sudo
#
#RUN useradd -ms /bin/bash marcos
#
#USER marcos
#WORKDIR /home/marcos

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y software-properties-common
RUN apt-add-repository -y --update ppa:ansible/ansible
RUN apt-get install -y curl git build-essential ansible vim tmux fzf cmake stow ripgrep sudo 
RUN apt-get update && \
    apt-get clean autoclean && \
    apt-get autoremove --yes


FROM base
RUN useradd --uid 1000 -ms /bin/bash marcos
RUN adduser marcos sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER marcos
WORKDIR /home/marcos

COPY . .
CMD ["sh", "-c", "ansible-playbook local.yml"]

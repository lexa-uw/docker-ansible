FROM williamyeh/ansible:alpine3-onbuild

MAINTAINER Alexey Tishkov <odin450@gmail.com>

RUN apk update && apk add git openssh sshpass

RUN pip install ansible==2.5.0rc3
RUN pip install docker

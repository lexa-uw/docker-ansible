FROM alpine:3.8

MAINTAINER Alexey Tishkov <odin450@gmail.com>

ENV ANSIBLE_VERSION=2.6.4

RUN set -xe \
    && echo "****** Install system dependencies ******" \
    && apk add --no-cache --progress python py-pip openssl \
		ca-certificates git openssh sshpass \
	&& apk --update add --virtual build-dependencies \
		python-dev libffi-dev openssl-dev build-base \
	\
	&& echo "****** Install ansible and python dependencies ******" \
    && pip install --upgrade pip \
	&& pip install ansible==${ANSIBLE_VERSION} boto boto3 \
    \
    && echo "****** Remove unused system librabies ******" \
	&& apk del build-dependencies \
	&& rm -rf /var/cache/apk/* 

RUN set -xe \
    && mkdir -p /etc/ansible \
    && echo -e "[local]\nlocalhost ansible_connection=local" > \
        /etc/ansible/hosts

CMD ["ansible", "--version"]

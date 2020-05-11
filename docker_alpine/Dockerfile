FROM alpine:3.10

MAINTAINER Roeland Siegers <roel@roelsieg.nl>

ENV ANSIBLE_VERSION=2.9.2

RUN set -xe \
    && echo "****** Install system dependencies ******" \
    && apk add --no-cache --progress python3 openssl \
		ca-certificates git openssh sshpass \
	&& apk --update add --virtual build-dependencies \
		python3-dev libffi-dev openssl-dev build-base \
        libxml2-dev libxslt-dev

COPY requirements.txt /root/requirements.txt

RUN set -xe \
	&& echo "****** Install ansible and python dependencies ******" \
    && pip3 install --upgrade pip \
    && pip3 install -r /root/requirements.txt \
        --no-cache-dir \
        --user \
        --no-warn-script-location \
        --pre 

RUN set -xe \
    && echo "****** Remove unused system librabies ******" \
	&& apk del build-dependencies \
	&& rm -rf /var/cache/apk/* 

RUN set -xe \
    && mkdir -p /etc/ansible \
    && echo -e "[local]\nlocalhost ansible_connection=local" > \
        /etc/ansible/hosts

RUN mkdir -p /ansible/playbooks

WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

ENTRYPOINT ["ansible-playbook"]

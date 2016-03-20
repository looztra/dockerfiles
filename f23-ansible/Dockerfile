FROM fedora:23
MAINTAINER christophe.furmaniak@gmail.com

RUN dnf clean all && \
    dnf update -y && \
    dnf install -y python-pip gcc make redhat-rpm-config python-devel && \
    pip install ansible && \
    mkdir -p /etc/ansible && \
    echo '[local]\nlocalhost\n' > /etc/ansible/hosts


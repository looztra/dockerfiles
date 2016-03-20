FROM fedora:23
MAINTAINER christophe.furmaniak@gmail.com

RUN dnf clean all && \
    dnf update -y && \
    dnf install -y python-pip gcc make redhat-rpm-config python-devel && \
    pip install ansible 'dopy>=0.3.5,<=0.3.5' && \
    mkdir -p /etc/ansible && \
    echo '[local]' > /etc/ansible/hosts && \
    echo localhost >> /etc/ansible/hosts && \
    echo >> /etc/ansible/hosts


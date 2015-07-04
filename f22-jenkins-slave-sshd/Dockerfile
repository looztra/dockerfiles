#FROM centos:7
FROM fedora:22
MAINTAINER Foo Bar "foo@bar.com"  
  
RUN dnf -y update && \
    dnf -y install openssh-server supervisor java-1.8.0-openjdk
  
RUN echo "root:password" | chpasswd  
RUN useradd jenkins  
RUN echo "jenkins:jenkins" | chpasswd  
  
RUN mkdir -p /var/run/sshd  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''  
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd  
  
RUN mkdir -p /var/run/supervisord  
ADD supervisord.conf /etc/supervisord.conf  
  
EXPOSE 22  
CMD ["/usr/bin/supervisord"]  

FROM ubuntu:20.04

# RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install -y openssh-server 
RUN apt-get install -y iproute2 iputils-ping net-tools build-essential tcpdump 

RUN mkdir /var/run/sshd

RUN echo 'root:katatema' | chpasswd
RUN sed -i 's/#\?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

EXPOSE 22

WORKDIR /dump
COPY ./dump /dump/
RUN make

WORKDIR /work
COPY ./setup.sh /work/setup.sh
RUN chmod +x /work/setup.sh


CMD ["/usr/sbin/sshd", "-D"]


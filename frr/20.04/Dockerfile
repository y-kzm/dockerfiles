FROM ubuntu:20.04
USER root

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update \
 && apt install -y iputils-ping traceroute sudo \
    vim git tmux curl silversearcher-ag bash-completion \
    netcat-openbsd telnet iperf tcpdump openvswitch-switch \
		bison flex iproute2 mtr python3-scapy curl pppoe pppoeconf lldpd \
		iptables ethtool gnupg2 gnupg1 lsb-release \
 &&	echo "" > ~/.bashrc \
 && echo "if [ -f /etc/bash_completion ] && ! shopt -oq posix; then" >> ~/.bashrc \
 && echo "  . /etc/bash_completion" >> ~/.bashrc \
 && echo "fi" >> ~/.bashrc \
 && rm -rf /var/lib/apt/lists/*

RUN curl -s https://deb.frrouting.org/frr/keys.asc | sudo apt-key add 
RUN FRRVER="frr-stable"
RUN echo deb https://deb.frrouting.org/frr $(lsb_release -s -c) frr-stable | sudo tee -a /etc/apt/sources.list.d/frr.list 
# RUN cat /etc/apt/sources.list 
# RUN cat /etc/apt/sources.list.d/frr.list  

RUN apt update 
RUN apt install -y frr frr-pythontools
RUN apt install -y libatm1 libc-ares2 \
      libelf1 libmnl0 libpopt0 libxtables12 logrotate protobuf-c-compiler \
      libprotobuf-c-dev libzmq5 libzmq3-dev \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i -e 's/=no/=yes/g' /etc/frr/daemons

# srv6_tracert
COPY ./srv6_tracert/ /srv6_tracert/
WORKDIR /srv6_tracert
RUN apt update && apt install -y python3-pip
RUN pip install --upgrade \
 && pip install --upgrade setuptools \
 && pip install netaddr \
 && pip install srv6_tracert
# RUN python3 setup.py install

# ref: https://github.com/slankdev/Dockerfiles/tree/master/ubuntu/18.04
ADD ./enable_seg6_router.py /usr/bin/enable_seg6_router.py
ADD ./disable_seg6_router.py /usr/bin/disable_seg6_router.py
RUN chmod +x /usr/bin/enable_seg6_router.py
RUN chmod +x /usr/bin/disable_seg6_router.py
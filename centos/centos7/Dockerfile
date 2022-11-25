FROM centos:centos7

RUN yum -y update

RUN yum -y groupinstall "Development Tools"
RUN yum -y install \ 
           kernel-devel \
           kernel-headers \
           gcc-c++ \
           patch \
           libyaml-devel \
           libffi-devel \
           autoconf \
           automake \
           make \
           libtool \
           bison \
           tk-devel \
           zip \
           wget \
           tar \
           gcc \
           zlib \
           zlib-devel \
           bzip2 \
           bzip2-devel \
           readline \
           readline-devel \
           sqlite \
           sqlite-devel \
           openssl \
           openssl-devel \
           git \
           gdbm-devel \
           python-devel \
           sudo 

WORKDIR /root
RUN wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
RUN tar xzvf Python-3.8.5.tgz

WORKDIR ./Python-3.8.5
RUN ./configure --with-threads
RUN make install

#RUN wget https://bootstrap.pypa.io/get-pip.py
RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
RUN python get-pip.py

#ENV LANG=C.UTF-8 \
#    LC_ALL=C.UTF-8 \
#    LC_CTYPE="utf-8"

WORKDIR /root
CMD ["/bin/bash"]




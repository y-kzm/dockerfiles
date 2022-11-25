FROM yykzm/ubuntu:20.04

RUN apt update \
 && apt install -y python-dev python-setuptools python3-pip

WORKDIR /temp
RUN git clone https://github.com/osrg/ryu.git
WORKDIR ryu/
RUN pip install .

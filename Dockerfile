FROM ubuntu:jammy
MAINTAINER @jbeley

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq -y update && \
        apt-get -qq -y --no-install-recommends install \
            software-properties-common \
            apt-transport-https \
            apt-utils \
            debfoster \
            software-properties-common \
            gpg-agent
RUN     apt-get -qq -y update && \
            apt-get -y --no-install-recommends install \
            git \
            build-essential \
            libssl-dev \
            python3

RUN git clone https://github.com/openwall/john /john
WORKDIR /john/src

RUN ./configure && \
    make -s clean && \
    make -s && \
    make install



#RUN echo -e python3\nlibgomp1 > /var/lib/debfoster/keepers && \
#                echo y | debfoster -f && \
#            apt-get -qq -y clean && \
#            apt-get -qq -y autoclean && \
#            apt-get -qq -y autoremove


WORKDIR /john/


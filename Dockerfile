FROM kalilinux/kali

LABEL maintainer="Matt Mcnamee"

# Environment Variables
ENV HOME=/root
ENV TOOLS="${HOME}/tools"
ENV WORDLISTS="${HOME}/wordlists"
ENV GO111MODULE=on
ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}

# Create working dirs
RUN mkdir ${TOOLS} && mkdir ${WORDLISTS}

# ------------------------------
# Common Dependencies
# ------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    awscli \
    build-essential \
    cpanminus \
    curl \
    dnsutils \
    gcc  \
    git \
    inetutils-ping  \
    libcurl4-openssl-dev \
    libgmp-dev \
    libldns-dev \
    libpcap-dev \
    libwww-perl \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    make  \
    nano \
    net-tools \
    perl  \
    python \
    python3 \
    python3-pip \
    ruby-dev \
    tmux \
    wget \
    whois  \
    zlib1g-dev \
    zsh

# Install go
RUN cd /opt && \
    wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz && \
    tar -xvf go1.13.3.linux-amd64.tar.gz && \
    rm -rf /opt/go1.13.3.linux-amd64.tar.gz && \
    mv go /usr/local

# Install Python common dependencies
RUN python3 -m pip install --upgrade setuptools && \
  python3 -m pip install --upgrade wheel html_similarity uvloop

# Install perl modules
RUN cpanm String::Random && \
  cpanm Net::IP && \
  cpanm Net::DNS && \
  cpanm Net::Netmask && \
  cpanm XML::Writer && \
  cpanm Net::FTP && \
  cpanm Time::HiRes && \
  cpanm HTTP::Lite && \
  cpanm Switch && \
  cpanm Socket && \
  cpanm IO::Socket && \
  cpanm Getopt::Std && \
  cpanm TFTP

# Set tzdata
RUN ln -fs /usr/share/zoneinfo/Australia/Brisbane /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

# ------------------------------
# Tools
# ------------------------------

# apt
RUN apt-get update && apt-get install -y --no-install-recommends \
  dirb \
  dnsrecon \
  nikto \
  nmap \
  sqlmap \
  hydra

# altdns
RUN git clone --depth 1 https://github.com/infosec-au/altdns.git ${TOOLS}/altdns && \
  cd ${TOOLS}/altdns && \
  python3 -m pip install -r requirements.txt && \
  chmod +x setup.py && \
  python3 setup.py install

# amass
RUN go get -v github.com/OWASP/Amass/v3/...

# bucket_finder
RUN git clone --depth 1 https://github.com/AlexisAhmed/bucket_finder.git ${TOOLS}/bucket_finder && \
  cd ${TOOLS}/bucket_finder && \
  chmod +x bucket_finder.rb && \
  ln -sf ${TOOLS}/bucket_finder/bucket_finder.rb /usr/local/bin/bucket_finder

# CloudFlair
RUN git clone --depth 1 https://github.com/christophetd/CloudFlair.git ${TOOLS}/cloudflair && \
  cd ${TOOLS}/cloudflair && \
  python3 -m pip install -r requirements.txt && \
  chmod +x cloudflair.py && \
  ln -sf ${TOOLS}/cloudflair/cloudflair.py /usr/local/bin/cloudflair

# commix
RUN git clone --depth 1 https://github.com/commixproject/commix.git ${TOOLS}/commix && \
  cd ${TOOLS}/commix && \
  chmod +x commix.py && \
  ln -sf ${TOOLS}/commix/commix.py /usr/local/bin/commix

# dirsearch
RUN git clone --depth 1 https://github.com/maurosoria/dirsearch.git ${TOOLS}/dirsearch && \
  cd ${TOOLS}/dirsearch && \
  chmod +x dirsearch.py && \
  ln -sf ${TOOLS}/dirsearch/dirsearch.py /usr/local/bin/dirsearch

# dnsenum
RUN git clone --depth 1 https://github.com/fwaeytens/dnsenum.git ${TOOLS}/dnsenum && \
  cd ${TOOLS}/dnsenum && \
  chmod +x dnsenum.pl && \
  ln -s ${TOOLS}/dnsenum/dnsenum.pl /usr/bin/dnsenum

# dotdotpwn
RUN git clone --depth 1 https://github.com/wireghoul/dotdotpwn.git ${TOOLS}/dotdotpwn && \
  cd ${TOOLS}/dotdotpwn && \
  chmod +x dotdotpwn.pl

# fierce
RUN python3 -m pip install fierce

# gobuster
RUN git clone --depth 1 https://github.com/OJ/gobuster.git ${TOOLS}/gobuster && \
  cd ${TOOLS}/gobuster && \
  go get && go install

# joomscan
RUN git clone --depth 1 https://github.com/rezasp/joomscan.git ${TOOLS}/joomscan && \
  cd ${TOOLS}/joomscan && \
  chmod +x joomscan.pl && \
  ln -sf ${TOOLS}/joomscan/joomscan.pl /usr/local/bin/joomscan

# knock
RUN git clone --depth 1 https://github.com/guelfoweb/knock.git ${TOOLS}/knock && \
  cd ${TOOLS}/knock && \
  chmod +x setup.py && \
  python3 setup.py install && \
  chmod +x knockpy/knockpy.py && \
  ln -sf ${TOOLS}/knock/knockpy/knockpy.py /usr/local/bin/knock

# masscan
RUN git clone --depth 1 https://github.com/robertdavidgraham/masscan.git ${TOOLS}/masscan && \
  cd ${TOOLS}/masscan && \
  make && \
  ln -sf ${TOOLS}/masscan/bin/masscan /usr/local/bin/masscan

# massdns
RUN git clone --depth 1 https://github.com/blechschmidt/massdns.git ${TOOLS}/massdns && \
  cd ${TOOLS}/massdns && \
  make && \
  ln -sf ${TOOLS}/massdns/bin/massdns /usr/local/bin/massdns

# Recon-ng
RUN git clone --depth 1 https://github.com/lanmaster53/recon-ng.git ${TOOLS}/recon-ng && \
  cd ${TOOLS}/recon-ng && \
  python3 -m pip install -r REQUIREMENTS && \
  chmod +x recon-ng && \
  ln -sf ${TOOLS}/recon-ng/recon-ng /usr/local/bin/recon-ng

# s3recon
RUN python3 -m pip install pyyaml pymongo requests s3recon

# subfinder
RUN go get -v github.com/projectdiscovery/subfinder/cmd/subfinder

# Sublist3r
RUN git clone --depth 1 https://github.com/aboul3la/Sublist3r.git ${TOOLS}/sublist3r && \
  cd ${TOOLS}/sublist3r && \
  python3 -m pip install -r requirements.txt && \
  ln -s ${TOOLS}/sublist3r/sublist3r.py /usr/local/bin/sublist3r

# teh_s3_bucketeers
RUN git clone --depth 1 https://github.com/tomdev/teh_s3_bucketeers.git ${TOOLS}/teh_s3_bucketeers && \
  cd ${TOOLS}/teh_s3_bucketeers && \
  chmod +x bucketeer.sh && \
  ln -sf ${TOOLS}/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer

# theHarvester
RUN git clone --depth 1 https://github.com/laramies/theHarvester ${TOOLS}/theharvester && \
  cd ${TOOLS}/theharvester && \
  python3 -m pip install -r requirements/base.txt && \
  chmod +x theHarvester.py && \
  ln -sf ${TOOLS}/theharvester/theHarvester.py /usr/local/bin/theharvester

# virtual-host-discovery
RUN git clone --depth 1 https://github.com/jobertabma/virtual-host-discovery.git ${TOOLS}/virtual-host-discovery && \
  cd ${TOOLS}/virtual-host-discovery && \
  chmod +x scan.rb && \
  ln -sf ${TOOLS}/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery

# wafw00f
RUN git clone --depth 1 https://github.com/enablesecurity/wafw00f.git ${TOOLS}/wafw00f && \
  cd ${TOOLS}/wafw00f && \
  chmod +x setup.py && \
  python3 setup.py install

# wfuzz
# RUN python3 -m pip install wfuzz

# whatweb
RUN git clone --depth 1 https://github.com/urbanadventurer/WhatWeb.git ${TOOLS}/whatweb && \
  cd ${TOOLS}/whatweb && \
  chmod +x whatweb && \
  ln -sf ${TOOLS}/whatweb/whatweb /usr/local/bin/whatweb

# wpscan
RUN git clone --depth 1 https://github.com/wpscanteam/wpscan.git ${TOOLS}/wpscan && \
  cd ${TOOLS}/wpscan && \
  gem install bundler && bundle install --without test && \
  gem install wpscan

# XSStrike
RUN git clone --depth 1 https://github.com/s0md3v/XSStrike.git ${TOOLS}/xsstrike && \
  cd ${TOOLS}/xsstrike && \
  python3 -m pip install -r requirements.txt && \
  chmod +x xsstrike.py && \
  ln -sf ${TOOLS}/xsstrike/xsstrike.py /usr/local/bin/xsstrike

# SecLists
RUN  git clone --depth 1 https://github.com/danielmiessler/SecLists.git ${WORDLISTS}/seclists

# Symlink wordlists
RUN ln -s /root/tools/theHarvester/wordlists ${WORDLISTS}/theharvester && \
  ln -s /usr/share/dirb/wordlists ${WORDLISTS}/dirb && \
  ln -s /root/tools/knock/knockpy/wordlist ${WORDLISTS}/knockpy

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*

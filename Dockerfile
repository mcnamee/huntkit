FROM kalilinux/kali

LABEL maintainer="Matt Mcnamee"

# Environment Variables
ENV HOME=/root
ENV TOOLS="/opt"
ENV ADDONS="${HOME}/addons"
ENV WORDLISTS="${HOME}/wordlists"
ENV GO111MODULE=on
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}

# Create working dirs
WORKDIR /root
RUN mkdir $WORDLISTS

# ------------------------------
# Common Dependencies
# ------------------------------

# Install Essentials
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    awscli \
    build-essential \
    curl \
    dnsutils \
    gcc \
    git \
    iputils-ping \
    jq \
    libgmp-dev \
    libpcap-dev \
    make \
    nano \
    netcat \
    net-tools \
    perl \
    python \
    python-pip \
    python3 \
    python3-pip \
    ssh \
    tmux \
    tzdata \
    wget \
    whois \
    zip \
    unzip \
    zsh

# Install tools & dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    brutespray \
    dirb \
    ftp \
    hydra \
    nikto \
    nmap \
    sqlmap \
    # johntheripper
    libssl-dev \
    yasm \
    pkg-config \
    libbz2-dev \
    # OpenVPN
    openvpn \
    easy-rsa \
    # wpscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    zlib1g-dev \
    # zsh
    fonts-powerline \
    powerline

RUN rm -rf /var/lib/apt/lists/*

# Install go
RUN cd /opt && \
    wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz && \
    tar -xvf go1.14.4.linux-amd64.tar.gz && \
    rm -rf /opt/go1.14.4.linux-amd64.tar.gz && \
    mv go /usr/local

# Install Python common dependencies
RUN pip install --upgrade setuptools wheel
RUN python3 -m pip install --upgrade setuptools wheel

# ------------------------------
# Tools
# ------------------------------

# amass
RUN go get -v github.com/OWASP/Amass/v3/...

# cloudfail
RUN git clone --depth 1 https://github.com/m0rtem/CloudFail.git $TOOLS/cloudfail && \
  cd $TOOLS/cloudfail && \
  python3 -m pip install -r requirements.txt && \
  sed -i 's^#!/usr/bin/env python3^#!/usr/bin/python3^g' cloudfail.py && \
  chmod a+x cloudfail.py && \
  ln -sf $TOOLS/cloudfail/cloudfail.py /usr/local/bin/cloudfail

# cloudflair
RUN git clone --depth 1 https://github.com/christophetd/CloudFlair.git $TOOLS/cloudflair && \
  cd $TOOLS/cloudflair && \
  python3 -m pip install -r requirements.txt && \
  sed -i 's^#!/usr/bin/env python3^#!/usr/bin/python3^g' cloudflair.py && \
  chmod a+x cloudflair.py && \
  ln -sf $TOOLS/cloudflair/cloudflair.py /usr/local/bin/cloudflair

# commix
RUN git clone --depth 1 https://github.com/commixproject/commix.git $TOOLS/commix && \
  cd $TOOLS/commix && \
  sed -i 's^#!/usr/bin/env python^#!/usr/bin/python3^g' commix.py && \
  chmod a+x commix.py && \
  ln -sf $TOOLS/commix/commix.py /usr/local/bin/commix

# dnmasscan
RUN git clone --depth 1 https://github.com/rastating/dnmasscan.git $TOOLS/dnmasscan && \
  cd $TOOLS/dnmasscan && \
  chmod a+x dnmasscan && \
  ln -sf $TOOLS/dnmasscan/dnmasscan /usr/local/bin/dnmasscan

# dnsprobe
RUN go get -u -v github.com/projectdiscovery/dnsprobe

# exploitdb (searchsploit)
RUN git clone https://github.com/offensive-security/exploitdb.git $TOOLS/exploitdb && \
  cd $TOOLS/exploitdb && \
  ln -sf $TOOLS/exploitdb/searchsploit /usr/bin/searchsploit

# fuff
RUN go get github.com/ffuf/ffuf

# gobuster
RUN git clone --depth 1 https://github.com/OJ/gobuster.git $TOOLS/gobuster && \
  cd $TOOLS/gobuster && \
  go get && go install

# httprobe
RUN go get -u github.com/tomnomnom/httprobe

# interlace
RUN git clone --depth 1 https://github.com/codingo/Interlace.git $TOOLS/interlace && \
  cd $TOOLS/interlace && \
  python3 -m pip install -r requirements.txt && \
  python3 setup.py install && \
  chmod a+x Interlace/interlace.py && \
  ln -sf $TOOLS/interlace/Interlace/interlace.py /usr/local/bin/interlace

# john the ripper
RUN git clone --depth 1 https://github.com/magnumripper/JohnTheRipper $TOOLS/john && \
  cd $TOOLS/john/src && \
  ./configure && make -s clean && make -sj4

# link finder
RUN git clone --depth 1 https://github.com/GerbenJavado/LinkFinder.git $TOOLS/linkfinder && \
  cd $TOOLS/linkfinder && \
  python3 -m pip install -r requirements.txt && \
  python3 setup.py install && \
  sed -i 's^#!/usr/bin/env python^#!/usr/bin/python3^g' linkfinder.py && \
  chmod a+x linkfinder.py && \
  ln -sf $TOOLS/linkfinder/linkfinder.py /usr/local/bin/linkfinder

# masscan
RUN git clone --depth 1 https://github.com/robertdavidgraham/masscan.git $TOOLS/masscan && \
  cd $TOOLS/masscan && \
  make -j && \
  ln -sf $TOOLS/masscan/bin/masscan /usr/local/bin/masscan

# meg
RUN go get -u github.com/tomnomnom/meg

# metasploit
RUN mkdir $TOOLS/metasploit && \
  cd $TOOLS/metasploit && \
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

# nuclei
RUN go get -u -v github.com/projectdiscovery/nuclei/cmd/nuclei && \
  git clone --depth 1 https://github.com/projectdiscovery/nuclei-templates.git $ADDONS/nuclei

# recon-ng
RUN git clone --depth 1 https://github.com/lanmaster53/recon-ng.git $TOOLS/recon-ng && \
  cd $TOOLS/recon-ng && \
  python3 -m pip install -r REQUIREMENTS && \
  chmod a+x recon-ng && \
  ln -sf $TOOLS/recon-ng/recon-ng /usr/local/bin/recon-ng

# pwncat
RUN python3 -m pip install pwncat

# sherlock
RUN git clone --depth 1 https://github.com/sherlock-project/sherlock $TOOLS/sherlock && \
  cd $TOOLS/sherlock && \
  python3 -m pip install -r requirements.txt && \
  chmod a+x sherlock/sherlock.py && \
  ln -sf $TOOLS/sherlock/sherlock/sherlock.py /usr/local/bin/sherlock

# social engineer toolkit
RUN git clone --depth 1 https://github.com/trustedsec/social-engineer-toolkit $TOOLS/setoolkit && \
  cd $TOOLS/setoolkit && \
  python3 -m pip install -r requirements.txt || : && \
  python setup.py || :

# subfinder
RUN go get -v github.com/projectdiscovery/subfinder/cmd/subfinder

# subjack
RUN go get github.com/haccer/subjack

# sublist3r
RUN git clone --depth 1 https://github.com/aboul3la/Sublist3r.git $TOOLS/sublist3r && \
  cd $TOOLS/sublist3r && \
  python3 -m pip install -r requirements.txt && \
  sed -i 's^#!/usr/bin/env python^#!/usr/bin/python3^g' sublist3r.py && \
  chmod a+x sublist3r.py && \
  ln -sf $TOOLS/sublist3r/sublist3r.py /usr/local/bin/sublist3r

# theharvester
# Note: it needs to be installed in /etc/ as there are absolute refs in the code
RUN git clone --depth 1 https://github.com/laramies/theHarvester /etc/theHarvester && \
  cd /etc/theHarvester && \
  python3 -m pip install pipenv && \
  python3 -m pip install -r requirements/base.txt && \
  sed -i 's^#!/usr/bin/env python3^#!/usr/bin/python3^g' theHarvester.py && \
  chmod a+x theHarvester.py && \
  ln -sf /etc/theHarvester/theHarvester.py /usr/local/bin/theharvester

# unfurl
RUN go get -u github.com/tomnomnom/unfurl

# wafw00f
RUN git clone --depth 1 https://github.com/enablesecurity/wafw00f.git $TOOLS/wafw00f && \
  cd $TOOLS/wafw00f && \
  chmod a+x setup.py && \
  python3 setup.py install

# whatweb
RUN git clone --depth 1 https://github.com/urbanadventurer/WhatWeb.git $TOOLS/whatweb && \
  cd $TOOLS/whatweb && \
  chmod a+x whatweb && \
  ln -sf $TOOLS/whatweb/whatweb /usr/local/bin/whatweb

# wpscan
RUN git clone --depth 1 https://github.com/wpscanteam/wpscan.git $TOOLS/wpscan && \
  cd $TOOLS/wpscan && \
  gem install bundler && bundle install --without test && \
  gem install wpscan

# xsstrike
RUN git clone --depth 1 https://github.com/s0md3v/XSStrike.git $TOOLS/xsstrike && \
  cd $TOOLS/xsstrike && \
  python3 -m pip install -r requirements.txt && \
  chmod a+x xsstrike.py && \
  ln -sf $TOOLS/xsstrike/xsstrike.py /usr/local/bin/xsstrike

# ------------------------------
# Wordlists
# ------------------------------

# seclists
RUN  git clone --depth 1 https://github.com/danielmiessler/SecLists.git $WORDLISTS/seclists

# rockyou
RUN curl -L https://github.com/praetorian-code/Hob0Rules/raw/db10d30b0e4295a648b8d1eab059b4d7a567bf0a/wordlists/rockyou.txt.gz \
  -o $WORDLISTS/rockyou.txt.gz && \
  gunzip $WORDLISTS/rockyou.txt.gz

# Symlink other wordlists
RUN ln -sf /etc/theHarvester/wordlists $WORDLISTS/theharvester && \
  ln -sf /usr/share/dirb/wordlists $WORDLISTS/dirb && \
  ln -sf /usr/share/metasploit-framework/data/wordlists $WORDLISTS/metasploit && \
  ln -sf $( find /go/pkg/mod/github.com/\!o\!w\!a\!s\!p/\!amass -name wordlists ) $WORDLISTS/amass

# ------------------------------
# Other utilities
# ------------------------------

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Australia/Brisbane /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

# Command line updates
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  chsh -s $(which zsh)

# Easier to access list of nmap scripts
RUN ln -s /usr/share/nmap/scripts/ $ADDONS/nmap

# Copy the startup script across
COPY ./startup.sh /startup.sh

# Common commands (aliases)
RUN echo "alias myip='dig +short myip.opendns.com @resolver1.opendns.com'" >> .zshrc

# Create a tools.md from README.md
COPY ./README.md /root/README.md

# ------------------------------
# Finished
# ------------------------------

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Start up commands
ENTRYPOINT ["bash", "/startup.sh"]
CMD ["/bin/zsh"]

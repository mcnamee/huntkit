FROM ubuntu

LABEL maintainer="Matt McNamee"

# Environment Variables
ENV HOME=/root
ENV TOOLS="/opt"
ENV ADDONS="/usr/share/addons"
ENV WORDLISTS="/usr/share/wordlists"
ENV GO111MODULE=on
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=${HOME}/:${GOPATH}/bin:${GOROOT}/bin:${PATH}
ENV DEBIAN_FRONTEND=noninteractive

# Create working dirs
WORKDIR /root
RUN mkdir $WORDLISTS && mkdir $ADDONS

# ------------------------------
# --- Common Dependencies ---
# ------------------------------

# Install Essentials
RUN apt-get update && \
  apt-get install -y --no-install-recommends --fix-missing \
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
  nodejs \
  npm \
  perl \
  php \
  proxychains \
  python3 \
  python3-pip \
  ssh \
  tor \
  tmux \
  tzdata \
  wget \
  whois \
  zip \
  unzip \
  zsh && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install tools & dependencies
RUN apt-get update && \
  apt-get install -y --no-install-recommends --fix-missing \
  brutespray \
  crunch \
  dirb \
  ftp \
  hping3 \
  hydra \
  nikto \
  nmap \
  smbclient \
  sqlmap \
  # johntheripper
  libssl-dev \
  yasm \
  pkg-config \
  libbz2-dev \
  # Metasploit
  gnupg2 \
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
  powerline && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install go
RUN cd /opt && \
  ARCH=$( arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/ ) && \
  wget https://dl.google.com/go/go1.21.1.linux-${ARCH}.tar.gz && \
  tar -xvf go1.21.1.linux-${ARCH}.tar.gz && \
  rm -rf /opt/go1.21.1.linux-${ARCH}.tar.gz && \
  mv go /usr/local

# Install Python common dependencies
RUN python3 -m pip install --upgrade setuptools wheel paramiko

# Install ZSH
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
  chsh -s $(which zsh)

# ------------------------------
# --- Tools ---
# ------------------------------

# amass
RUN go install -v github.com/owasp-amass/amass/v3/...@master

# cloudfail - not working with latest python3
# RUN git clone --depth 1 https://github.com/m0rtem/CloudFail.git $TOOLS/cloudfail && \
#   cd $TOOLS/cloudfail && \
#   python3 -m pip install -r requirements.txt && \
#   sed -i 's^#!/usr/bin/env python3^#!/usr/bin/python3^g' cloudfail.py && \
#   chmod a+x cloudfail.py && \
#   ln -sf $TOOLS/cloudfail/cloudfail.py /usr/local/bin/cloudfail

# breach-parse
RUN git clone --depth 1 https://github.com/hmaverickadams/breach-parse.git $TOOLS/breach-parse && \
  cd $TOOLS/breach-parse && \
  chmod a+x breach-parse.sh && \
  ln -sf $TOOLS/breach-parse/breach-parse.sh /usr/local/bin/breach-parse

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

# cupp
RUN git clone --depth 1 https://github.com/Mebus/cupp.git $TOOLS/cupp && \
  cd $TOOLS/cupp && \
  chmod a+x cupp.py && \
  ln -sf $TOOLS/cupp/cupp.py /usr/local/bin/cupp

# dalfox
RUN git clone --depth 1 https://github.com/hahwul/dalfox.git $TOOLS/dalfox && \
  cd $TOOLS/dalfox && \
  go install && \
  rm -rf $TOOLS/dalfox

# dnmasscan
RUN git clone --depth 1 https://github.com/rastating/dnmasscan.git $TOOLS/dnmasscan && \
  cd $TOOLS/dnmasscan && \
  chmod a+x dnmasscan && \
  ln -sf $TOOLS/dnmasscan/dnmasscan /usr/local/bin/dnmasscan

# dnsprobe
RUN go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# exploitdb (searchsploit)
RUN git clone --depth 1 https://github.com/offensive-security/exploitdb.git $TOOLS/exploitdb && \
  cd $TOOLS/exploitdb && \
  ln -sf $TOOLS/exploitdb/searchsploit /usr/bin/searchsploit

# fuff
RUN go install github.com/ffuf/ffuf@latest

# gau
RUN go install github.com/lc/gau/v2/cmd/gau@latest && \
  echo "alias gau='/go/bin/gau'" >> ~/.zshrc

# httpx
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

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
  echo "alias john='${TOOLS}/john/run/john'" >> ~/.zshrc && \
  ./configure && make -s clean && make -sj4

# jwttool
RUN git clone --depth 1 https://github.com/ticarpi/jwt_tool $TOOLS/jwttool && \
  cd $TOOLS/jwttool && \
  python3 -m pip install pycryptodomex termcolor && \
  chmod a+x jwt_tool.py && \
  ln -sf $TOOLS/jwttool/jwt_tool.py /usr/local/bin/jwttool

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
RUN go install -v github.com/tomnomnom/meg@latest

# metasploit
RUN mkdir $TOOLS/metasploit && \
  cd $TOOLS/metasploit && \
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

# nuclei
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
  git clone --depth 1 https://github.com/projectdiscovery/nuclei-templates.git $ADDONS/nuclei

# pagodo
RUN git clone --depth 1 https://github.com/opsdisk/pagodo.git $TOOLS/pagodo && \
  cd $TOOLS/pagodo && \
  python3 -m pip install -r requirements.txt && \
  sed -i 's^#!/usr/bin/env python^#!/usr/bin/python3^g' pagodo.py && \
  python3 ghdb_scraper.py -j -s && \
  chmod a+x pagodo.py && \
  ln -sf $TOOLS/pagodo/pagodo.py /usr/local/bin/pagodo

# recon-ng
RUN git clone --depth 1 https://github.com/lanmaster53/recon-ng.git $TOOLS/recon-ng && \
  cd $TOOLS/recon-ng && \
  python3 -m pip install -r REQUIREMENTS && \
  chmod a+x recon-ng && \
  ln -sf $TOOLS/recon-ng/recon-ng /usr/local/bin/recon-ng

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
  python3 setup.py || :

# subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# subjs
RUN go install -v github.com/lc/subjs@latest

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
RUN go install -v github.com/tomnomnom/unfurl@latest

# wafw00f
RUN git clone --depth 1 https://github.com/enablesecurity/wafw00f.git $TOOLS/wafw00f && \
  cd $TOOLS/wafw00f && \
  chmod a+x setup.py && \
  python3 setup.py install

# wfuzz
# RUN pip install wfuzz

# whatweb
RUN git clone --depth 1 https://github.com/urbanadventurer/WhatWeb.git $TOOLS/whatweb && \
  cd $TOOLS/whatweb && \
  chmod a+x whatweb && \
  ln -sf $TOOLS/whatweb/whatweb /usr/local/bin/whatweb

# wpscan
RUN gem install wpscan

# xsstrike
RUN git clone --depth 1 https://github.com/s0md3v/XSStrike.git $TOOLS/xsstrike && \
  cd $TOOLS/xsstrike && \
  python3 -m pip install -r requirements.txt && \
  chmod a+x xsstrike.py && \
  ln -sf $TOOLS/xsstrike/xsstrike.py /usr/local/bin/xsstrike

# ------------------------------
# --- Wordlists ---
# ------------------------------

# seclists
RUN  git clone --depth 1 https://github.com/danielmiessler/SecLists.git $WORDLISTS/seclists

# rockyou
RUN curl -L https://github.com/praetorian-code/Hob0Rules/raw/db10d30b0e4295a648b8d1eab059b4d7a567bf0a/wordlists/rockyou.txt.gz \
  -o $WORDLISTS/rockyou.txt.gz && \
  gunzip $WORDLISTS/rockyou.txt.gz

# Symlink other wordlists
RUN ln -sf $( find /go/pkg/mod/github.com/\!o\!w\!a\!s\!p/\!amass -name wordlists ) $WORDLISTS/amass && \
  ln -sf /usr/share/brutespray/wordlist $WORDLISTS/brutespray && \
  ln -sf /usr/share/dirb/wordlists $WORDLISTS/dirb && \
  ln -sf /usr/share/setoolkit/src/fasttrack/wordlist.txt $WORDLISTS/fasttrack.txt && \
  ln -sf /opt/metasploit-framework/embedded/framework/data/wordlists $WORDLISTS/metasploit && \
  ln -sf /usr/share/nmap/nselib/data/passwords.lst $WORDLISTS/nmap.lst && \
  ln -sf /etc/theHarvester/wordlists $WORDLISTS/theharvester

# ------------------------------
# --- Other utilities ---
# ------------------------------

# Kali reverse shells
RUN git clone --depth 1 https://gitlab.com/kalilinux/packages/webshells.git /usr/share/webshells && \
  ln -s /usr/share/webshells $ADDONS/webshells

# Copy the startup script across
COPY ./startup.sh /startup.sh

# ------------------------------
# --- Config ---
# ------------------------------

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Australia/Brisbane /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

# Easier to access list of nmap scripts
RUN ln -s /usr/share/nmap/scripts/ $ADDONS/nmap

# Proxychains config
RUN echo "dynamic_chain" > /etc/proxychains.conf && \
  echo "proxy_dns" >> /etc/proxychains.conf && \
  echo "tcp_read_time_out 15000" >> /etc/proxychains.conf && \
  echo "tcp_connect_time_out 8000" >> /etc/proxychains.conf && \
  echo "[ProxyList]" >> /etc/proxychains.conf && \
  echo "socks5 127.0.0.1 9050" >> /etc/proxychains.conf

# Common commands (aliases)
RUN echo "alias myip='dig +short myip.opendns.com @resolver1.opendns.com'" >> ~/.zshrc

# ZSH config
RUN sed -i 's^ZSH_THEME="robbyrussell"^ZSH_THEME="bira"^g' ~/.zshrc && \
  sed -i 's^# DISABLE_UPDATE_PROMPT="true"^DISABLE_UPDATE_PROMPT="true"^g' ~/.zshrc && \
  sed -i 's^# DISABLE_AUTO_UPDATE="true"^DISABLE_AUTO_UPDATE="true"^g' ~/.zshrc && \
  sed -i 's^plugins=(git)^plugins=(tmux nmap)^g' ~/.zshrc && \
  echo 'export EDITOR="nano"' >> ~/.zshrc && \
  git config --global oh-my-zsh.hide-info 1

# Clean up space - remove version control
RUN cd $HOME && find . -name '.git' -type d -exec rm -rf {} + && \
  cd $TOOLS && find . -name '.git' -type d -exec rm -rf {} + && \
  cd $ADDONS && find . -name '.git' -type d -exec rm -rf {} + && \
  cd $WORDLISTS && find . -name '.git' -type d -exec rm -rf {} + && \
  rm -rf /root/.cache

# ------------------------------
# --- Finished ---
# ------------------------------

# Start up commands
ENTRYPOINT ["bash", "/startup.sh"]
CMD ["/bin/zsh"]

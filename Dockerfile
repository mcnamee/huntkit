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
WORKDIR /root
RUN mkdir ${TOOLS} && mkdir ${WORDLISTS}

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
    make \
    nano \
    net-tools \
    perl \
    python \
    python3 \
    python3-pip \
    tmux \
    tzdata \
    wget \
    whois \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    brutespray \
    dirb \
    hydra \
    nikto \
    nmap \
    sqlmap \
    # masscan
    libpcap-dev \
    # wpscan
    libcurl4-openssl-dev \
    libgmp-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    zlib1g-dev \
    # zsh
    fonts-powerline \
    powerline

# Install go
RUN cd /opt && \
    wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz && \
    tar -xvf go1.14.4.linux-amd64.tar.gz && \
    rm -rf /opt/go1.14.4.linux-amd64.tar.gz && \
    mv go /usr/local

# Install Python common dependencies
RUN python3 -m pip install --upgrade setuptools wheel

# ------------------------------
# Tools
# ------------------------------

# amass
RUN go get -v github.com/OWASP/Amass/v3/...

# cloudflair
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

# dnmasscan
RUN git clone --depth 1 https://github.com/rastating/dnmasscan.git ${TOOLS}/dnmasscan && \
  ln -sf ${TOOLS}/dnmasscan/dnmasscan /usr/local/bin/dnmasscan

# exploitdb (searchsploit)
RUN git clone https://github.com/offensive-security/exploitdb.git ${TOOLS}/exploitdb && \
  cd ${TOOLS}/exploitdb && \
  ln -s ${TOOLS}/exploitdb/searchsploit /usr/bin/searchsploit

# fierce
RUN python3 -m pip install fierce

# gobuster
RUN git clone --depth 1 https://github.com/OJ/gobuster.git ${TOOLS}/gobuster && \
  cd ${TOOLS}/gobuster && \
  go get && go install

# metasploit
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && ./msfinstall

# masscan
RUN git clone --depth 1 https://github.com/robertdavidgraham/masscan.git ${TOOLS}/masscan && \
  cd ${TOOLS}/masscan && \
  make -j && \
  ln -sf ${TOOLS}/masscan/bin/masscan /usr/local/bin/masscan

# recon-ng
RUN git clone --depth 1 https://github.com/lanmaster53/recon-ng.git ${TOOLS}/recon-ng && \
  cd ${TOOLS}/recon-ng && \
  python3 -m pip install -r REQUIREMENTS && \
  chmod +x recon-ng && \
  ln -sf ${TOOLS}/recon-ng/recon-ng /usr/local/bin/recon-ng

# social engineer toolkit
RUN git clone --depth 1 https://github.com/trustedsec/social-engineer-toolkit ${TOOLS}/setoolkit && \
  cd ${TOOLS}/setoolkit && \
  python3 -m pip install -r requirements.txt || : && \
  python setup.py || :

# subfinder
RUN go get -v github.com/projectdiscovery/subfinder/cmd/subfinder

# sublist3r
RUN git clone --depth 1 https://github.com/aboul3la/Sublist3r.git ${TOOLS}/sublist3r && \
  cd ${TOOLS}/sublist3r && \
  python3 -m pip install -r requirements.txt && \
  ln -s ${TOOLS}/sublist3r/sublist3r.py /usr/local/bin/sublist3r

# theharvester
RUN git clone --depth 1 https://github.com/laramies/theHarvester ${TOOLS}/theharvester && \
  cd ${TOOLS}/theharvester && \
  python3 -m pip install pipenv && \
  python3 -m pip install -r requirements/base.txt && \
  chmod +x theHarvester.py && \
  ln -sf ${TOOLS}/theharvester/theHarvester.py /usr/local/bin/theharvester

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

# xsstrike
RUN git clone --depth 1 https://github.com/s0md3v/XSStrike.git ${TOOLS}/xsstrike && \
  cd ${TOOLS}/xsstrike && \
  python3 -m pip install -r requirements.txt && \
  chmod +x xsstrike.py && \
  ln -sf ${TOOLS}/xsstrike/xsstrike.py /usr/local/bin/xsstrike

# ------------------------------
# Wordlists
# ------------------------------

# seclists
RUN  git clone --depth 1 https://github.com/danielmiessler/SecLists.git ${WORDLISTS}/seclists

# Symlink other wordlists
RUN ln -s /root/tools/theharvester/wordlists ${WORDLISTS}/theharvester && \
  ln -s /usr/share/dirb/wordlists ${WORDLISTS}/dirb

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
RUN ln -s /usr/share/nmap/scripts/ $HOME/nmap-scripts

# Copy the startup script across
COPY ./startup.sh /startup.sh

# ------------------------------
# Finished
# ------------------------------

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Start up commands
ENTRYPOINT ["bash", "/startup.sh"]
CMD ["/bin/zsh"]

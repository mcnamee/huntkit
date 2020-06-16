<div align="center">
  <h1>Pen Test Toolkit</h1>
  <p></p>
  <sup>
    <a href="https://github.com/mcnamee/pentest-toolkit/actions">
      <img src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fmcnamee%2Fpentest-toolkit%2Fbadge%3Fref%3Dmaster&style=flat" alt="builds" />
    </a>
    <a href="/LICENSE">
      <img src="https://img.shields.io/github/license/mcnamee/pentest-toolkit?style=flat-square" alt="license" />
    </a>
  </sup>
  <br />
  <p align="center">
    <a href="#-intro"><b>What is this?</b></a>
    &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
    <a href="#-instructions"><b>Instructions</b></a>
    &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
    <a href="#-tools"><b>Tools</b></a>
  </p>
  <br />
</div>

## Instructions

```bash
docker run -it mcnamee/pentest-toolkit /bin/bash
```

### Docker Build

```bash
# 1. Clone the repo

# 2. Build the image
docker build . -t mcnamee/pentest-toolkit

# 3. Run
docker run -it mcnamee/pentest-toolkit /bin/bash
```

## Tools

| Tool | Command |
| --- | --- |
| [altdns](https://github.com/infosec-au/altdns) | `altdns --help` |
| [Amass](https://github.com/OWASP/Amass) | `amass --help` |
| [bucket_finder](https://github.com/AlexisAhmed/bucket_finder) | `bucket_finder --help` |
| [CloudFlair](https://github.com/christophetd/CloudFlair) | `cloudflair --help` |
| [commix](https://github.com/commixproject/commix) | `commix --help` |
| [dirb](https://tools.kali.org/web-applications/dirb) | `dirb` |
| [dirsearch](https://github.com/maurosoria/dirsearch) | `dirsearch --help` |
| [dnsenum](https://github.com/fwaeytens/dnsenum) | `dnsenum --help` |
| [dnsrecon](https://tools.kali.org/information-gathering/dnsrecon) | `dnsrecon` |
| [dotdotpwn](https://github.com/wireghoul/dotdotpwn) | `perl /root/tools/dotdotpwn/dotdotpwn.pl --help` |
| [fierce](https://github.com/mschwager/fierce) | `fierce --help` |
| [gobuster](https://github.com/OJ/gobuster) | `gobuster --help` |
| [joomscan](https://github.com/rezasp/joomscan) | `perl ~/tools/joomscan/joomscan.pl` |
| [knock](https://github.com/guelfoweb/knock) | `knock --help` |
| [masscan](https://github.com/robertdavidgraham/masscan) | `masscan --help` |
| [massdns](https://github.com/blechschmidt/massdns) | `massdns --help` |
| [nikto](https://tools.kali.org/information-gathering/nikto) | `nikto --help` |
| [nmap](https://nmap.org/) | `nmap --help` |
| [recon-ng](https://github.com/lanmaster53/recon-ng) | `recon-ng` |
| [s3recon](https://s3recon.readthedocs.io/en/latest/) | `s3recon --help` |
| [sqlmap](http://sqlmap.org/) | `sqlmap --help` |
| [subfinder](https://github.com/projectdiscovery/subfinder) | `subfinder --help` |
| [sublist3r](https://github.com/aboul3la/Sublist3r) | `sublist3r --help` |
| [teh_s3_bucketeers](https://github.com/tomdev/teh_s3_bucketeers) | `bucketeer` |
| [hydra](https://tools.kali.org/password-attacks/hydra) | `hydra -h` |
| [theharvester](https://tools.kali.org/information-gathering/theharvester) | `python3 ~/tools/theharvester/theHarvester.py --help` |
| [tmux](https://github.com/tmux/tmux/wiki) | n/a |
| [virtual-host-discovery](https://github.com/jobertabma/virtual-host-discovery) | `virtual-host-discovery --help` |
| [wafw00f](https://github.com/enablesecurity/wafw00f) | `wafw00f --help` |
| [wfuzz](https://wfuzz.readthedocs.io/en/latest/) | `wfuzz --help` |
| [whatweb](https://github.com/urbanadventurer/WhatWeb) | `whatweb --help` |
| [wpscan](https://github.com/wpscanteam/wpscan) | `wpscan --help` |
| [xsstrike](https://github.com/s0md3v/XSStrike) | `xsstrike --help` |
| [zsh](https://ohmyz.sh/) | n/a |

## Wordlists

- [SecLists](https://github.com/danielmiessler/SecLists)

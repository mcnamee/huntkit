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
    <a href="#intro"><b>What is this?</b></a>
    &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
    <a href="#instructions"><b>Instructions</b></a>
    &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
    <a href="#tools"><b>Tools</b></a>
  </p>
  <br />
</div>

## What is this?

A collection of pen testing in a single Docker container. Simply run the image and start using the tools.

__Why?__

I got sick of waiting for VitualBox to boot, Kali to boot, then dealing with the slugish-ness of operating in a VM. I still use Kali for certain tasks. But for a quick nmap scan (for example), this image is a lot quicker.

## Instructions

```bash
# ••• Run from Docker Hub •••
docker run -it mcnamee/pentest-toolkit /bin/zsh

# --- OR ---

# ••• Build from the repo •••
# 1. Clone the repo
# 2. Build the image
docker build . -t mcnamee/pentest-toolkit
# 3. Run
docker run -it mcnamee/pentest-toolkit /bin/zsh
```

## Tools

### Information Gathering - General

| Tool | Description | Example |
| --- | --- | --- |
| [Amass](https://github.com/OWASP/Amass) | - | `amass enum -v -src -ip -brute -min-for-recursive 2 -d kali.org` |
| [CloudFlair](https://github.com/christophetd/CloudFlair) | - | `export CENSYS_API_ID=... && export CENSYS_API_SECRET=...` <br> `cloudflair resound.ly` |
| [dnsenum](https://github.com/fwaeytens/dnsenum) | - | `dnsenum kali.org -enum -f $WORDLISTS/seclists/Discovery/DNS/subdomains-top1million-5000.txt` |
| [fierce](https://github.com/mschwager/fierce) | - | `fierce --domain kali.org` |
| [gobuster](https://github.com/OJ/gobuster) | - | - `gobuster dns -d kali.org -w $WORDLISTS/seclists/Discovery/DNS/fierce-hostlist.txt` <br>- `gobuster dir -u https://www.kali.org  -w $WORDLISTS/dirb/common.txt` <br>- `gobuster vhost -u kali.org  -w $WORDLISTS/seclists/Discovery/DNS/fierce-hostlist.txt` |
| [nmap](https://nmap.org/) | - | `nmap -sV 192.168.0.1` |
| [recon-ng](https://github.com/lanmaster53/recon-ng) | - | `recon-ng` |
| [subfinder](https://github.com/projectdiscovery/subfinder) | - | `subfinder -d kali.org -v` |
| [sublist3r](https://github.com/aboul3la/Sublist3r) | - | `cd $TOOLS/sublist3r` <br>`python3 sublist3r.py -d kali.org` |
| [theharvester](https://tools.kali.org/information-gathering/theharvester) | - | `cd $TOOLS/theharvester/` <br> <code>theharvester -d kali.org -b "bing, certspotter,dnsdumpster,dogpile,duckduckgo,google,hunter,linkedin,linkedin_links,twitter,yahoo"</code> |
| [virtual-host-discovery](https://github.com/jobertabma/virtual-host-discovery) | - | `cd $TOOLS/virtual-host-discovery` <br>`ruby scan.rb --ip=157.245.155.29 --host=resound.ly` |

### Information Gathering - Web Application

| Tool | Description | Example |
| --- | --- | --- |
| [dirb](https://tools.kali.org/web-applications/dirb) | - | `dirb https://kali.org $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt` |
| [dirsearch](https://github.com/maurosoria/dirsearch) | - | <code>dirsearch -u kali.org -w $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt -e php</code> |
| [joomscan](https://github.com/rezasp/joomscan) | - | `perl ~/tools/joomscan/joomscan.pl` |
| [nikto](https://tools.kali.org/information-gathering/nikto) | - | `nikto -host=https://kali.org` |
| [wafw00f](https://github.com/enablesecurity/wafw00f) | - | | `wafw00f resound.ly` |
| [whatweb](https://github.com/urbanadventurer/WhatWeb) | - | `whatweb kali.org` |
| [wpscan](https://github.com/wpscanteam/wpscan) | - | `wpscan --url kali.org` |
| [xsstrike](https://github.com/s0md3v/XSStrike) | - | `xsstrike --help` |

### Exploitation Tools

| Tool | Description | Example |
| --- | --- | --- |
| [commix](https://github.com/commixproject/commix) | - | `commix --help` |
| [hydra](https://tools.kali.org/password-attacks/hydra) | - | <code>hydra -f -l email@admin.com -P $WORDLISTS/seclists/Passwords/darkweb2017-top1000.txt http-post-form "/login:user=^USER^&pass=^PASS^:Failed" website.com</code> |
| [sqlmap](http://sqlmap.org/) | - | `sqlmap -u https://example.com --forms --crawl=10 --level=5 --risk=3` |

### Other

| Tool |
| --- |
| [tmux](https://github.com/tmux/tmux/wiki) |
| [zsh](https://ohmyz.sh/) |

## Wordlists

- [SecLists](https://github.com/danielmiessler/SecLists)

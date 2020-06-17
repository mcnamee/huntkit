<div align="center">
  <h1>Pen Test Toolkit</h1>
  <p></p>
  <sup>
    <a href="https://github.com/s0md3v/XSStrike/releases">
      <img src="https://img.shields.io/github/release/mcnamee/pentest-toolkit.svg">
    </a>
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
docker run -it mcnamee/pentest-toolkit

# --- OR ---

# ••• Run from Docker Hub and mount a folder (to access a folder from within) •••
 docker run -itv ~/Projects:/root/projects mcnamee/pentest-toolkit

# --- OR ---

# ••• Build from the repo •••
# 1. Clone the repo
# 2. Build the image
docker build . -t mcnamee/pentest-toolkit
# 3. Run
docker run -it mcnamee/pentest-toolkit
```

## Tools

### Information Gathering - General

| Tool | Description & Example |
| --- | --- |
| [amass](https://github.com/OWASP/Amass) | _Network mapping of attack surfaces and external asset discovery using open source information gathering and active reconnaissance techniques._ <br>`amass enum -v -src -ip -brute -min-for-recursive 2 -d kali.org` |
| [cloudflair](https://github.com/christophetd/CloudFlair) | _CloudFlair is a tool to find origin servers of websites protected by CloudFlare who are publicly exposed and don't restrict network access to the CloudFlare IP ranges as they should._ <br> `export CENSYS_API_ID=... && export CENSYS_API_SECRET=...` <br> `cloudflair resound.ly` |
| [dnsenum](https://github.com/fwaeytens/dnsenum) | _Enumerate DNS information of a domain and to discover non-contiguous ip blocks._ <br> `dnsenum kali.org -enum -f $WORDLISTS/seclists/Discovery/DNS/subdomains-top1million-5000.txt` |
| [fierce](https://github.com/mschwager/fierce) | _A DNS reconnaissance tool for locating non-contiguous IP space._ <br> `fierce --domain kali.org` |
| [gobuster](https://github.com/OJ/gobuster) | _Gobuster is a tool used to brute-force: URIs (directories and files), DNS subdomains, Virtual Hosts._ <br> - `gobuster dns -d kali.org -w $WORDLISTS/seclists/Discovery/DNS/fierce-hostlist.txt` <br>- `gobuster dir -u https://www.kali.org  -w $WORDLISTS/dirb/common.txt` <br>- `gobuster vhost -u kali.org  -w $WORDLISTS/seclists/Discovery/DNS/fierce-hostlist.txt` |
| [nmap](https://nmap.org/) | _A utility for network discovery and security auditing_. <br> `nmap -sV 192.168.0.1` |
| [recon-ng](https://github.com/lanmaster53/recon-ng) | _Web-based open source reconnaissance framework._ <br> `recon-ng` |
| [subfinder](https://github.com/projectdiscovery/subfinder) | _Subdomain discovery tool to find valid subdomains for websites by using passive online sources._ <br> `subfinder -d kali.org -v` |
| [sublist3r](https://github.com/aboul3la/Sublist3r) | _Enumerates subdomains using many search engines such as Google, Yahoo, Bing, Baidu and more._ <br> `cd $TOOLS/sublist3r` <br>`python3 sublist3r.py -d kali.org` |
| [theharvester](https://tools.kali.org/information-gathering/theharvester) | _Gather emails, subdomains, hosts, employee names, open ports and banners from different public sources like search engines, PGP key servers and SHODAN computer database._ <br> `cd $TOOLS/theharvester/` <br> <code>theharvester -d kali.org -b "bing, certspotter,dnsdumpster,dogpile,duckduckgo,google,hunter,linkedin,linkedin_links,twitter,yahoo"</code> |
| [virtual-host-discovery](https://github.com/jobertabma/virtual-host-discovery) | _HTTP scanner that'll enumerate virtual hosts on a given IP address._ <br> `cd $TOOLS/virtual-host-discovery` <br>`ruby scan.rb --ip=157.245.155.29 --host=resound.ly` |

### Information Gathering - Web Application

| Tool | Description & Example |
| --- | --- |
| [dirb](https://tools.kali.org/web-applications/dirb) | _Looks for existing (and/or hidden) Web Objects, by launching a dictionary based attack against a web server and analyzing the response._ <br> `dirb https://kali.org $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt` |
| [dirsearch](https://github.com/maurosoria/dirsearch) | _Brute forcees directories and files in websites to find things you might be interested in._ <br> <code>dirsearch -u kali.org -w $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt -e php</code> |
| [joomscan](https://github.com/rezasp/joomscan) | _Vulnerability detection for Joomla CMS._ <br> `perl ~/tools/joomscan/joomscan.pl` |
| [nikto](https://tools.kali.org/information-gathering/nikto) | _Web server scanner which performs comprehensive tests against web servers for multiple items (dangerous files, outdated dependencies...)._ <br> `nikto -host=https://kali.org` |
| [wafw00f](https://github.com/enablesecurity/wafw00f) | _Web Application Firewall Fingerprinting Tool._ <br> `wafw00f resound.ly` |
| [whatweb](https://github.com/urbanadventurer/WhatWeb) | _Scans websites and highlights the CMS used, JavaScript libraries, web servers, version numbers, email addresses, account IDs, web framework modules, SQL errors, and more._ <br> `whatweb kali.org` |
| [wpscan](https://github.com/wpscanteam/wpscan) | _WordPress Security Scanner._ <br> `wpscan --url kali.org` |
| [xsstrike](https://github.com/s0md3v/XSStrike) | _Advanced XSS Detection Suite._ <br> `xsstrike --help` |

### Exploitation Tools

| Tool | Description & Example |
| --- | --- |
| [commix](https://github.com/commixproject/commix) | `commix --help` |
| [hydra](https://tools.kali.org/password-attacks/hydra) | <code>hydra -f -l email@admin.com -P $WORDLISTS/seclists/Passwords/darkweb2017-top1000.txt http-post-form "/login:user=^USER^&pass=^PASS^:Failed" website.com</code> |
| [sqlmap](http://sqlmap.org/) | `sqlmap -u https://example.com --forms --crawl=10 --level=5 --risk=3` |

### Other

| Tool | Description |
| --- | --- |
| [tmux](https://github.com/tmux/tmux/wiki) | tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal. |
| [Oh My Zsh](https://ohmyz.sh/) | Zsh is a framework for managing your zsh configuration, bundled with thousands of helpful functions, helpers, plugins, themes. |
| [zsh](https://www.zsh.org/) | Zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh. |

## Wordlists

- [SecLists](https://github.com/danielmiessler/SecLists)

## Coming soon...

- [] Stay anonymous
- [] Social-Engineer Toolkit

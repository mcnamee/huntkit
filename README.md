<div align="center">
  <h1>Pen Test Toolkit</h1>
  <p></p>
  <sup>
    <a href="https://hub.docker.com/r/mcnamee/pentest-toolkit">
      <img src="https://img.shields.io/docker/v/mcnamee/pentest-toolkit?style=flat-square" alt="version" />
    </a>
    <a href="https://github.com/mcnamee/pentest-toolkit/actions">
      <img alt="Build Status" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fmcnamee%2Fpentest-toolkit%2Fbadge&label=build&logo=none" />
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

### Run from DockerHub

```bash
docker run -it mcnamee/pentest-toolkit

# - OR - build and mount a folder (for persistence)
docker run -itv ~/Projects:/root/projects mcnamee/pentest-toolkit
```

[![asciicast](https://asciinema.org/a/343938.svg)](https://asciinema.org/a/343938)

### Build

```bash
# 1. Clone the repo
git clone https://github.com/mcnamee/pentest-toolkit.git && cd pentest-toolkit

# 2. Build the image
docker build . -t mcnamee/pentest-toolkit
```

## Tools

### Recon

| Tool | Description & Example |
| --- | --- |
| [amass](https://github.com/OWASP/Amass) | _Network mapping of attack surfaces and external asset discovery using open source information gathering and active reconnaissance techniques._ <br>`amass enum -v -src -ip -brute -min-for-recursive 2 -d kali.org` |
| [brutespray](https://github.com/x90skysn3k/brutespray) | _Service scanner by bruteforcing._ <br>`brutespray --file nmap.gnmap` |
| [cloudflair](https://github.com/christophetd/CloudFlair) | _CloudFlair is a tool to find origin servers of websites protected by CloudFlare who are publicly exposed and don't restrict network access to the CloudFlare IP ranges as they should._ <br> `export CENSYS_API_ID=... && export CENSYS_API_SECRET=...` <br> `cloudflair resound.ly` |
| [dirb](https://tools.kali.org/web-applications/dirb) | _Looks for existing (and/or hidden) Web Objects, by launching a dictionary based attack against a web server and analyzing the response._ <br> `dirb https://kali.org $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt` |
| [dirsearch](https://github.com/maurosoria/dirsearch) | _Brute forcees directories and files in websites to find things you might be interested in._ <br> <code>dirsearch -u kali.org -w $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt -e php</code> |
| [dnmasscan](https://github.com/rastating/dnmasscan) | _dnmasscan is a bash script to automate resolving a file of domain names and subsequentlly scanning them using masscan._ <br> `dnmasscan listofdomains.txt dns.log -p80,443 - oG masscan.log` |
| [fierce](https://github.com/mschwager/fierce) | _A DNS reconnaissance tool for locating non-contiguous IP space._ <br> `fierce --domain kali.org` |
| [gobuster](https://github.com/OJ/gobuster) | _Gobuster is a tool used to brute-force: URIs (directories and files), DNS subdomains, Virtual Hosts._ <br> - `gobuster dns -d kali.org -w $WORDLISTS/seclists/Discovery/DNS/fierce-hostlist.txt` <br>- `gobuster dir -u https://www.kali.org  -w $WORDLISTS/dirb/common.txt` <br>- `gobuster vhost -u kali.org  -w $WORDLISTS/seclists/Discovery/DNS/fierce-hostlist.txt` |
| [masscan](https://github.com/robertdavidgraham/masscan) | _An Internet-scale port scanner._ <br> `masscan -p1-65535 -iL listofips.txt --max-rate 1800 -oG masscan.log` |
| [nikto](https://tools.kali.org/information-gathering/nikto) | _Web server scanner which performs comprehensive tests against web servers for multiple items (dangerous files, outdated dependencies...)._ <br> `nikto -host=https://kali.org` |
| [nmap](https://nmap.org/) | _A utility for network discovery and security auditing_. <br> `nmap -sV 192.168.0.1` |
| [recon-ng](https://github.com/lanmaster53/recon-ng) | _Web-based open source reconnaissance framework._ <br> `recon-ng` |
| [subfinder](https://github.com/projectdiscovery/subfinder) | _Subdomain discovery tool to find valid subdomains for websites by using passive online sources._ <br> `subfinder -d kali.org -v` |
| [sublist3r](https://github.com/aboul3la/Sublist3r) | _Enumerates subdomains using many search engines such as Google, Yahoo, Bing, Baidu and more._ <br> `( cd $TOOLS/sublist3r && python3 sublist3r.py -d kali.org )` |
| [theharvester](https://tools.kali.org/information-gathering/theharvester) | _Gather emails, subdomains, hosts, employee names, open ports and banners from different public sources like search engines, PGP key servers and SHODAN computer database._ <br> <code>( cd $TOOLS/theharvester/ && theharvester -d kali.org -b "bing, certspotter, dnsdumpster, dogpile, duckduckgo, google, hunter, linkedin, linkedin_links, twitter, yahoo" )</code> |
| [wafw00f](https://github.com/enablesecurity/wafw00f) | _Web Application Firewall Fingerprinting Tool._ <br> `wafw00f resound.ly` |
| [whatweb](https://github.com/urbanadventurer/WhatWeb) | _Scans websites and highlights the CMS used, JavaScript libraries, web servers, version numbers, email addresses, account IDs, web framework modules, SQL errors, and more._ <br> `whatweb kali.org` |
| [wpscan](https://github.com/wpscanteam/wpscan) | _WordPress Security Scanner._ <br> `wpscan --url kali.org` |
| [xsstrike](https://github.com/s0md3v/XSStrike) | _Advanced XSS Detection Suite._ <br> `xsstrike --help` |

### Exploitation

| Tool | Description & Example |
| --- | --- |
| [commix](https://github.com/commixproject/commix) | _Command injection exploiter - used to test web applications with the view to find bugs, errors or vulnerabilities related to command injection attacks._ <br> `commix --url="http://192.168.0.23/commix-testbed/scenarios/referer/referer(classic).php" --level=3` |
| [metasploit](https://tools.kali.org/exploitation-tools/metasploit-framework) | _A penetration testing platform that enables you to find, exploit, and validate vulnerabilities.._ <br> `msfconsole` |
| [hydra](https://tools.kali.org/password-attacks/hydra) | <code>hydra -f -l email@admin.com -P $WORDLISTS/seclists/Passwords/darkweb2017-top1000.txt http-post-form "/login:user=^USER^&pass=^PASS^:Failed" website.com</code> |
| [searchsploit](https://tools.kali.org/exploitation-tools/exploitdb) | _Searchable archive from The Exploit Database._ <br> `searchsploit oracle windows remote` |
| [setoolkit](https://www.trustedsec.com/tools/the-social-engineer-toolkit-set/) | _Social Engineering Toolkit._ <br> `setoolkit` |
| [sqlmap](http://sqlmap.org/) | `sqlmap -u https://example.com --forms --crawl=10 --level=5 --risk=3` |

### Other

| Tool | Description |
| --- | --- |
| [tmux](https://github.com/tmux/tmux/wiki) | tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal. |
| [Oh My Zsh](https://ohmyz.sh/) | Zsh is a framework for managing your zsh configuration, bundled with thousands of helpful functions, helpers, plugins, themes. |
| [zsh](https://www.zsh.org/) | Zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh. |

## Wordlists

- [SecLists](https://github.com/danielmiessler/SecLists)

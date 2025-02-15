<div align="center">
  <img src="https://github.com/mcnamee/huntkit/raw/master/docs/hero.png" alt="HuntKit" style="width:100%" />
  <p></p>
  <sup>
    <a href="https://hub.docker.com/r/mcnamee/huntkit">
      <img src="https://img.shields.io/docker/v/mcnamee/huntkit?style=flat-square" alt="version" />
    </a>
    <a href="/LICENSE">
      <img src="https://img.shields.io/github/license/mcnamee/huntkit?style=flat-square" alt="license" />
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

HuntKit is a collection of [penetration testing, bug bounty hunting, capture the flag, red teaming] tools in a single Docker image. Simply run the image and start using the tools.

__Why?__

I got sick of waiting for VitualBox to start, Kali to boot, then dealing with the slugish-ness of operating in a VM. I still use Kali for certain tasks. But for a quick nmap scan (for example), using this container is *a lot* quicker.

- The tool run very __quick__ (opposed to running inside a VM for example)
- Simpler to keep the tools __up to date__
- __Disposable__ - Something broken? Simply prune and start again

## Instructions

### Run from DockerHub

```bash
docker run -it mcnamee/huntkit
```

<details>
  <summary>Advanced usage</summary>

  ```bash
  # Advanced:
  # Line 2: maps ~/Loot to the Docker's /root/loot
  # Line 3: Allows OpenVPN usage
  # Line 4: Opens and maps port 4444 (for listeners such as Metasploit)
  # Line 5: Sets the machine's hostname to huntkit
  docker run -it \
    -v ~/Loot:/root/loot \
    --cap-add=NET_ADMIN --device=/dev/net/tun \
    -p 4444:4444 \
    -h huntkit \
    mcnamee/huntkit
  ```
</details>

<details>
  <summary>(Update) Pull the latest from Docker Hub</summary>

  ```bash
  docker pull mcnamee/huntkit
  ```
</details>

<details>
  <summary>Build it yourself</summary>

  ```bash
  # 1. Clone the repo
  git clone https://github.com/mcnamee/huntkit.git && cd huntkit

  # 2. Build the image
  docker build . -t mcnamee/huntkit
  ```
</details>

[![asciicast](https://asciinema.org/a/403549.svg)](https://asciinema.org/a/403549)

## Tools

### Recon

| Tool | Description & Example |
| --- | --- |
| [amass](https://github.com/OWASP/Amass) | _Network mapping of attack surfaces and external asset discovery using open source information gathering and active reconnaissance techniques._ <br>`amass enum -v -src -ip -brute -min-for-recursive 2 -d kali.org` |
| [brutespray](https://github.com/x90skysn3k/brutespray) | _Service scanner by bruteforcing._ <br>`brutespray --file nmap.gnmap` |
| [commix](https://github.com/commixproject/commix) | _Command injection exploiter - used to test web applications with the view to find bugs, errors or vulnerabilities related to command injection attacks._ <br> `commix --url="http://192.168.0.23/commix-testbed/scenarios/referer/referer(classic).php" --level=3` |
| [dalfox](https://github.com/hahwul/dalfox) | _XSS Scanning and Parameter Analysis tool._ <br> `dalfox url http://testphp.vulnweb.com/listproducts.php\?cat\=123 -b https://hahwul.xss.ht` |
| [dirb](https://tools.kali.org/web-applications/dirb) | _Looks for existing (and/or hidden) Web Objects, by launching a dictionary based attack against a web server and analyzing the response._ <br> `dirb https://kali.org $WORDLISTS/seclists/Discovery/Web-Content/CommonBackdoors-PHP.fuzz.txt` |
| [dnmasscan](https://github.com/rastating/dnmasscan) | _dnmasscan is a bash script to automate resolving a file of domain names and subsequentlly scanning them using masscan._ <br> `dnmasscan listofdomains.txt dns.log -p80,443 - oG masscan.log` |
| [dnsx](https://github.com/projectdiscovery/dnsx) | _Allows you to run multiple probers using retryabledns library, that allows you to perform multiple DNS queries of your choice with a list of user supplied resolvers._ <br> <code>cat domains.txt &#124; dnsx</code> |
| [ffuf](https://github.com/ffuf/ffuf) | _A fast web fuzzer._ <br> - `ffuf -w /path/to/postdata.txt -X POST -d "username=admin\&password=FUZZ" -u https://target/login.php -fc 401` |
| [gau](https://github.com/lc/gau) | _getallurls (gau) fetches known URLs from AlienVault's Open Threat Exchange, the Wayback Machine, and Common Crawl for any given domain._ <br> - `gau example.com` |
| [httpx](https://github.com/projectdiscovery/httpx) | _Take a list of domains and probe for working http and https servers._ <br> <code>cat domains.txt &#124; httpx</code> |
| [linkfinder](https://github.com/GerbenJavado/LinkFinder) | _Discover endpoints and their parameters in JavaScript files._ <br> `linkfinder -i https://example.com -d -o cli` |
| [masscan](https://github.com/robertdavidgraham/masscan) | _An Internet-scale port scanner._ <br> `masscan -p1-65535 -iL listofips.txt --max-rate 1800 -oG masscan.log` |
| [meg](https://github.com/robertdavidgraham/masscan) | _A tool for fetching lots of URLs but still being 'nice' to servers._ <br> `meg paths.txt hosts.txt` |
| [nikto](https://tools.kali.org/information-gathering/nikto) | _Web server scanner which performs comprehensive tests against web servers for multiple items (dangerous files, outdated dependencies...)._ <br> `nikto -host=https://kali.org` |
| [nmap](https://nmap.org/) | _A utility for network discovery and security auditing_. <br> `nmap -sV 192.168.0.1` |
| [nuclei](https://github.com/projectdiscovery/nuclei) | _Nuclei is a fast tool for configurable targeted scanning based on templates offering massive extensibility and ease of use._. <br> `nuclei -l urls.txt -t $ADDONS/nuclei/ADDONS/nuclei/technologies/ -o ~/projects/results.txt` |
| [pagodo](https://github.com/opsdisk/pagodo) | _Passive Google dork script to collect potentially vulnerable web pages and applications on the Internet._. <br> `pagodo -d $DOMAIN -g dorks/sensitive_directories.dorks -l 100 -s -e 35.0 -j 1.1` |
| [recon-ng](https://github.com/lanmaster53/recon-ng) | _Web-based open source reconnaissance framework._ <br> `recon-ng` |
| [sherlock](https://github.com/sherlock-project/sherlock) | _Hunt down social media accounts by username across social networks._ <br> `sherlock user1 user2 user3` |
| [subfinder](https://github.com/projectdiscovery/subfinder) | _Subdomain discovery tool to find valid subdomains for websites by using passive online sources._ <br> `subfinder -d kali.org -v` |
| [subjs](https://github.com/lc/subjs) | _Fetches javascript files from a list of URLS or subdomains. Analyzing javascript files can help you find undocumented endpoints, secrets, and more._ <br> <code>cat urls.txt &#124; subjs</code> |
| [sublist3r](https://github.com/aboul3la/Sublist3r) | _Enumerates subdomains using many search engines such as Google, Yahoo, Bing, Baidu and more._ <br> `sublist3r -d kali.org` |
| [sqlmap](http://sqlmap.org/) | _Automates the process of detecting and exploiting SQL injection flaws and taking over of database servers_ <br> `sqlmap -u https://example.com --forms --crawl=10 --level=5 --risk=3` |
| [theharvester](https://tools.kali.org/information-gathering/theharvester) | _Gather emails, subdomains, hosts, employee names, open ports and banners from different public sources like search engines, PGP key servers and SHODAN computer database._ <br> <code>theharvester -d kali.org -b "bing, certspotter, dnsdumpster, dogpile, duckduckgo, google, hunter, linkedin, linkedin_links, twitter, yahoo"</code> |
| [wafw00f](https://github.com/enablesecurity/wafw00f) | _Web Application Firewall Fingerprinting Tool._ <br> `wafw00f resound.ly` |
| [whatweb](https://github.com/urbanadventurer/WhatWeb) | _Scans websites and highlights the CMS used, JavaScript libraries, web servers, version numbers, email addresses, account IDs, web framework modules, SQL errors, and more._ <br> `whatweb kali.org` |
| [wpscan](https://github.com/wpscanteam/wpscan) | _WordPress Security Scanner._ <br> `wpscan --url kali.org` |
| [xsstrike](https://github.com/s0md3v/XSStrike) | _Advanced XSS Detection Suite._ <br> `xsstrike -u="http://192.168.0.115" --data="query"` |

### Exploitation

| Tool | Description & Example |
| --- | --- |
| [breach-parse](https://github.com/hmaverickadams/breach-parse) | _A tool for parsing breached passwords._<br> `breach-parse @tesla.com tesla.txt "~/Downloads/BreachCompilation/data"` |
| [crunch](https://tools.kali.org/password-attacks/crunch) | _Wordlist generator where you can specify a standard character set or a character set you specify._ <br> `crunch 6 6 0123456789abcdef -o 6chars.txt` |
| [cupp](https://github.com/Mebus/cupp) | _Personal wordlist generator._ <br> `cupp -i` |
| [john](https://github.com/magnumripper/JohnTheRipper) | _John the Ripper is a fast password cracker._ <br> `zip2john filename.zip > hash.txt`<br> `john hash.txt` |
| [jwttool](https://github.com/ticarpi/jwt_tool) | _A toolkit for validating, forging and cracking JWTs (JSON Web Tokens)._ <br> `jwttool eyJ0eXAiOiJ.eyJsb2dpbi.aqNCvShlN -A` |
| [metasploit](https://tools.kali.org/exploitation-tools/metasploit-framework) | _A penetration testing platform that enables you to find, exploit, and validate vulnerabilities.._ <br> `msfconsole` |
| [hydra](https://tools.kali.org/password-attacks/hydra) | <code>hydra -f -l email@admin.com -P $WORDLISTS/seclists/Passwords/darkweb2017-top1000.txt website.com http-post-form "/login:user=^USER^&pass=^PASS^:Failed"</code> |
| [netcat](http://netcat.sourceforge.net/) | _A networking utility which reads and writes data across network connections, using the TCP/IP protocol._ <br> `nc -nvlp 1234` |
| [searchsploit](https://tools.kali.org/exploitation-tools/exploitdb) | _Searchable archive from The Exploit Database._ <br> `searchsploit oracle windows remote` |
| [setoolkit](https://www.trustedsec.com/tools/the-social-engineer-toolkit-set/) | _Social Engineering Toolkit._ <br> `setoolkit` |

### Other

| Tool | Description |
| --- | --- |
| FTP | _Connect to an FTP server._ <br> `ftp ftp.google.com` |
| [Go](https://golang.org/) | The Go programming language |
| [Interlace](https://github.com/codingo/Interlace) | _Easily turn single threaded command line applications into a fast, multi-threaded application._ <br> `interlace -tL targets.txt -threads 5 -c "gobuster dns -d _target_ -w wordlist.txt --noprogress --quiet >> _target_.txt" -v` |
| [NodeJS](https://nodejs.org/) | _Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine._ |
| [Oh My Zsh](https://ohmyz.sh/) | _Zsh is a framework for managing your zsh configuration, bundled with thousands of helpful functions, helpers, plugins, themes._ |
| [OpenVPN](https://openvpn.net/) | _Connect to a VPN._ <br> Add `--cap-add=NET_ADMIN --device=/dev/net/tun` to the `docker run` to use OpenVPN. |
| [Perl](https://www.perl.org/) | _Perl is a highly capable, feature-rich programming language with over 30 years of development._ |
| [PHP](https://www.php.net/) | _The PHP scripting language._ |
| [Proxychains](https://github.com/haad/proxychains) | _Redirects connections through SOCKS4a/5 or HTTP proxies._ |
| [Python 3](https://www.python.org/) | _The Python programming language_ |
| [Ruby](https://www.ruby-lang.org/) | _A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write._ |
| [smbclient](https://installlion.com/kali/kali/main/s/smbclient/install/index.html) | `smbclient \\192.168.0.45\Media` |
| [Tor](https://www.torproject.org/) | _Browse Privately._ |
| [tmux](https://github.com/tmux/tmux/wiki) | _tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal._ <br>`CNTR+b c` Create window <br>`CNTR+b n` Switch to next window |
| [unfurl](https://github.com/tomnomnom/unfurl) | _Pull out bits of URLs provided on stdin._ <br> <code>cat urls.txt &#124; unfurl --unique domains</code> |
| [zsh](https://www.zsh.org/) | _Zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh._ |

<!-- END -->

## Wordlists

- Amass
- Dirb
- Kali's `rockyou.txt`
- Metasploit
- The Harvester
- [SecLists](https://github.com/danielmiessler/SecLists)

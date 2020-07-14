#!/usr/bin/env bash
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
NC='\033[0m'

# Print a welcome message
echo -e '////////////////////////////////////////////////////////////////////////';
echo -e '      ██████  ███████ ███    ██ ████████ ███████ ███████ ████████ '
echo -e '      ██   ██ ██      ████   ██    ██    ██      ██         ██'
echo -e '      ██████  █████   ██ ██  ██    ██    █████   ███████    ██    '
echo -e '      ██      ██      ██  ██ ██    ██    ██           ██    ██'
echo -e '      ██      ███████ ██   ████    ██    ███████ ███████    ██'
echo -e '  '
echo -e '      ████████  ██████   ██████  ██      ██   ██ ██ ████████'
echo -e '         ██    ██    ██ ██    ██ ██      ██  ██  ██    ██'
echo -e '         ██    ██    ██ ██    ██ ██      █████   ██    ██'
echo -e '         ██    ██    ██ ██    ██ ██      ██  ██  ██    ██'
echo -e '         ██     ██████   ██████  ███████ ██   ██ ██    ██'
echo -e '////////////////////////////////////////////////////////////////////////';
echo -e '             Built and maintained by https://mcn.am'
echo -e '            https://github.com/mcnamee/pentest-toolkit'
echo -e "${BOLD}"
echo -e '    Recon  —  Exploitation  —  Privilege Escalation  —  Persistence'
echo -e "${NORMAL}${RED}"
echo -e "        ► Should you be running through a VPN or TOR Proxy? ◄"
echo -e "${NC}"

# Create a tools.md from README.md
README=$( cat /root/README.md )
README=$( echo $README | awk '/## Tools/{s=x}{s=s$0"\n"}/<!-- END -->/{print s}' )
README=$( echo $README | sed 's^<!-- END -->^^g' )
README=$( echo $README | tr -d "\r\v" )
README=$( echo $README | sed 's^| Tool | Description & Example |^^g' )
README=$( echo $README | sed 's^| Tool | Description |^^g' )
README=$( echo $README | sed 's^| --- | --- |^^g' )
README=$( echo $README | tr '|' '\n' )
README=$( echo $README | sed 's^<br>^\n^g' )
README=$( echo $README | sed 's^<code>^ `^g' )
README=$( echo $README | sed 's^</code>^`^g' )
README=$( echo $README | sed 's^_^^g' )
README=$( echo $README | sed 's^- ^^g' )
README=$( echo $README | sed '/^$/d' )
README=$( echo $README | sed 's^\[^\n\- [^g' )
README=$( echo $README | sed 's^\##^\n\#^g' )
echo $README > tools.md
rm README.md

# Ensure the final executable receives the Unix signals
exec "$@"

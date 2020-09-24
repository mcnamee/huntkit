#!/usr/bin/env zsh
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
NC='\033[0m'
MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# Print a welcome message
echo -e '      ██╗  ██╗██╗   ██╗███╗   ██╗████████╗██╗  ██╗██╗████████╗'
echo -e '      ██║  ██║██║   ██║████╗  ██║╚══██╔══╝██║ ██╔╝██║╚══██╔══╝'
echo -e '      ███████║██║   ██║██╔██╗ ██║   ██║   █████╔╝ ██║   ██║   '
echo -e '      ██╔══██║██║   ██║██║╚██╗██║   ██║   ██╔═██╗ ██║   ██║   '
echo -e '      ██║  ██║╚██████╔╝██║ ╚████║   ██║   ██║  ██╗██║   ██║   '
echo -e '      ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝   ╚═╝   '
echo -e '          Built and maintained by https://mcn.am'
echo -e '            https://github.com/mcnamee/huntkit'
echo -e "${BOLD}"
echo -e '  Recon  —  Exploitation  —  Privilege Escalation  —  Persistence'
echo -e "${NORMAL}${RED}"
echo -e "                 Your IP is: ${MYIP}"
echo -e "${NC}"

# Start tor
service tor start > /dev/null 2>&1

# Ensure the final executable receives the Unix signals
exec "$@"

#!/usr/bin/env bash
bold=$(tput bold)
normal=$(tput sgr0)

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
echo -e "${bold}"
echo -e '    Recon  —  Exploitation  —  Privilege Escalation  —  Persistence'
echo -e "${normal}"

# Ensure the final executable receives the Unix signals
exec "$@"

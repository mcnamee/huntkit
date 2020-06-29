#!/usr/bin/env bash
bold=$(tput bold)
normal=$(tput sgr0)

# Print a welcome message
echo -e ' \n '
echo -e '////////////////////////////////////////////////////////////////////////';
echo -e '    ____          _____         _     _____           _ _    _ _    '
echo -e '   |  _ \ ___ _ _|_   _|__  ___| |_  |_   _|__   ___ | | | _(_) |_  '
echo -e '   | |_) / _ \ `_ \| |/ _ \/ __| __|   | |/ _ \ / _ \| | |/ / | __| '
echo -e '   |  __/  __/ | | | |  __/\__ \ |_    | | (_) | (_) | |   <| | |_  '
echo -e '   |_|   \___|_| |_|_|\___||___/\__|   |_|\___/ \___/|_|_|\_\_|\__| '
echo -e '////////////////////////////////////////////////////////////////////////';
echo -e '               Built and maintained by https://mcn.am'
echo -e '            https://github.com/mcnamee/pentest-toolkit'
echo -e "${bold}"
echo -e '     Recon  —  Exploitation  —  Privilege Escalation  —  Persistence'
echo -e "${normal}"

# Ensure the final executable receives the Unix signals
exec "$@"

#!/usr/bin/env bash
#
# HuntKit smoke test.
#
# Verifies that every tool the Dockerfile installs is present on PATH (and
# that a handful of critical ones actually execute), plus that the key
# wordlist / addon directories are wired up. Runs *inside* a built image:
#
#   docker run --rm -v "$PWD/tests:/tests" --entrypoint bash mcnamee/huntkit /tests/smoke.sh
#
# Exits non-zero if anything is missing, so it can gate CI without a human
# eyeballing a 20-minute build.

set -u

pass=0
fail=0
fails=()

ok()   { pass=$((pass + 1)); printf '  \033[32mok\033[0m    %s\n' "$1"; }
bad()  { fail=$((fail + 1)); fails+=("$1"); printf '  \033[31mFAIL\033[0m  %s\n' "$1"; }

# present <command>  — tool must resolve on PATH
present() {
  if command -v "$1" >/dev/null 2>&1; then ok "$1"; else bad "$1 (not on PATH)"; fi
}

# runs <label> <cmd> [args...]  — command must exit 0 (proves it actually starts)
runs() {
  local label=$1; shift
  if "$@" >/dev/null 2>&1; then ok "$label (runs)"; else bad "$label (present but exit $?)"; fi
}

# exists <path>  — file or directory must exist (follows symlinks)
exists() {
  if [ -e "$1" ]; then ok "$1"; else bad "$1 (missing)"; fi
}

echo "== apt-provided tools =="
for t in brutespray crunch dirb ftp hping3 hydra nikto nmap smbclient sqlmap openvpn sherlock; do
  present "$t"
done

echo "== Go tools =="
for t in amass dalfox dnsx ffuf gau httpx meg nuclei subfinder subjs unfurl; do
  present "$t"
done

echo "== git / compiled / script tools =="
for t in breach-parse commix cupp dnmasscan searchsploit interlace jwttool \
         linkfinder masscan pagodo recon-ng sublist3r theharvester whatweb xsstrike; do
  present "$t"
done
# john is not symlinked onto PATH — it's a zsh alias to the compiled binary
exists /opt/john/run/john

echo "== pip / gem tools =="
present wafw00f
present wpscan

echo "== metasploit =="
# omnibus installer symlinks msfconsole into /usr/bin, but accept the
# framework bin path too in case PATH isn't wired up yet
if command -v msfconsole >/dev/null 2>&1 || [ -x /opt/metasploit-framework/bin/msfconsole ]; then
  ok msfconsole
else
  bad "msfconsole (not found)"
fi

echo "== execute a critical subset =="
runs nmap        nmap --version
runs nuclei      nuclei -version
runs httpx       httpx -version
runs ffuf        ffuf -V
runs theharvester theharvester -h
runs wpscan      wpscan --version

echo "== wordlists & addons =="
exists /usr/share/wordlists/seclists
exists /usr/share/wordlists/rockyou.txt
exists /usr/share/addons/nuclei
exists /usr/share/addons/nmap
exists /usr/share/addons/webshells

echo
echo "-------------------------------------"
printf 'passed: %d   failed: %d\n' "$pass" "$fail"
if [ "$fail" -ne 0 ]; then
  printf 'failures: %s\n' "${fails[*]}"
  exit 1
fi
echo "all smoke checks passed"

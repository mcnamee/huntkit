# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

HuntKit is a single Docker image bundling penetration-testing / bug-bounty / CTF tools (recon, exploitation, wordlists) on top of `ubuntu`, published to Docker Hub as `mcnamee/huntkit`. There is no application code — the entire product is the `Dockerfile`. Most "development" here means adding, removing, or updating a tool in the image.

## Common commands

```bash
# Build the image locally (multi-arch aware; the Dockerfile auto-detects amd64/arm64)
docker build . -t mcnamee/huntkit

# Run it interactively (drops into zsh via startup.sh)
docker run -it mcnamee/huntkit

# Full run with loot volume, OpenVPN, and a listener port (see README)
docker run -it -v ~/Loot:/root/loot --cap-add=NET_ADMIN --device=/dev/net/tun -p 4444:4444 -h huntkit mcnamee/huntkit

# Regenerate the bare-metal Ubuntu installer from the Dockerfile (see below)
./docker-to-bash.sh

# Push to Docker Hub
docker build . -t mcnamee/huntkit && docker login && docker push mcnamee/huntkit
```

There is no test suite, linter, or build system beyond Docker. Verify changes by building the image and running the affected tool inside the container.

## Architecture / key facts

- **`Dockerfile` is the source of truth.** It is organized into commented sections: Common Dependencies → Tools → Wordlists → Other utilities → Config. Each tool is its own `RUN` layer. The install pattern for git-based tools is consistent: `git clone --depth 1` into `$TOOLS`, install deps, `chmod +x`, then `ln -sf` a symlink into `/usr/local/bin` so the tool is on `PATH`. Go tools use `go install`. Match the surrounding style when adding a tool.

- **`install-in-ubuntu.sh` is GENERATED, never edit it by hand.** `docker-to-bash.sh` transforms the `Dockerfile` into this bash script (stripping `FROM`/`LABEL`/`WORKDIR`/`COPY`/`ENTRYPOINT`/`CMD`, converting `RUN`→plain commands and `ENV`→`export`) so HuntKit can be installed directly on a raw Ubuntu host too big/small for Docker. After changing the `Dockerfile`, re-run `./docker-to-bash.sh` to keep it in sync.

- **Environment variables define the layout** (set in `Dockerfile`, mirrored in the generated installer): `$TOOLS=/opt` (cloned tools), `$ADDONS=/usr/share/addons` (nuclei templates, nmap scripts, webshells), `$WORDLISTS=/usr/share/wordlists` (SecLists, rockyou, and symlinks into tool-bundled wordlists), plus Go paths (`GOROOT=/usr/local/go`, `GOPATH=/go`).

- **`startup.sh`** is the `ENTRYPOINT` — it prints the banner then `exec "$@"` (default `CMD` is `/bin/zsh`), so Unix signals reach the shell.

- **Python installs use `--break-system-packages`** because the base Ubuntu enforces PEP 668; keep this flag on any new `pip install`. Several Python tools rewrite their shebang from `#!/usr/bin/env python` to `#!/usr/bin/python3` via `sed`.

- **Publishing** is manual: the `.github/workflows/docker-hub.yml` GitHub Action is `workflow_dispatch`-only (no automatic build on push) and builds `linux/amd64,linux/arm64` via Buildx/QEMU, tagging `mcnamee/huntkit:latest`. Docker Hub credentials come from repo secrets.

- **The README tool tables are documentation of what's installed.** When you add or remove a tool in the `Dockerfile`, update the corresponding row (with a usage example) in `README.md`.

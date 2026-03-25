#!/usr/bin/env bash
set -euo pipefail

REPO="https://raw.githubusercontent.com/ben-macpherson/wt-activate/main/bin"
INSTALL_DIR="${1:-/usr/local/bin}"

die() { printf 'install: error: %s\n' "$*" >&2; exit 1; }

if [[ ! -d "$INSTALL_DIR" ]]; then
  die "install directory does not exist: ${INSTALL_DIR}"
fi

if [[ ! -w "$INSTALL_DIR" ]]; then
  die "cannot write to ${INSTALL_DIR}. Try one of:
  sudo bash install.sh
  bash install.sh ~/.local/bin"
fi

for script in wt-activate wt-activate-init; do
  printf 'Installing %s -> %s/%s\n' "$script" "$INSTALL_DIR" "$script"
  curl -fsSL "${REPO}/${script}" -o "${INSTALL_DIR}/${script}"
  chmod +x "${INSTALL_DIR}/${script}"
done

printf '\nInstalled successfully.\n'
printf 'Make sure %s is in your PATH.\n' "$INSTALL_DIR"

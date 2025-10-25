#!/usr/bin/env bash
set -euo pipefail

# ============================================
#  UFW Firewall Setup Helper
#  Dual-mode: rebuild or modify individual ports.
# ============================================

# Default configuration
ports=(22 80 443 9443)   # Default allowed ports when rebuilding
remote_exec=true          # Prevent locking yourself out of SSH

# --- Helper Functions ---
usage() {
  echo "Usage:"
  echo "  $0                Rebuild UFW with default port set"
  echo "  $0 add <port>     Allow a specific port (non-destructive)"
  echo "  $0 remove <port>  Remove a specific port"
  echo
  echo "Examples:"
  echo "  sudo $0"
  echo "  sudo $0 add 8080"
  echo "  sudo $0 remove 8080"
  exit 1
}

require_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "[ERROR] This script must be run as root." >&2
    exit 1
  fi
}

# --- Main Logic ---
require_root

action=${1:-rebuild}
port_arg=${2:-}

case "$action" in
  add)
    if [[ -z "$port_arg" ]]; then
      echo "[ERROR] Port number required. Example: sudo $0 add 8080"
      exit 1
    fi
    echo "[INFO] Allowing TCP port $port_arg..."
    ufw allow "${port_arg}/tcp"
    ufw reload
    ufw status verbose | grep "$port_arg" || echo "[WARN] Port not found in rules."
    ;;

  remove)
    if [[ -z "$port_arg" ]]; then
      echo "[ERROR] Port number required. Example: sudo $0 remove 8080"
      exit 1
    fi
    echo "[INFO] Removing TCP port $port_arg..."
    ufw delete allow "${port_arg}/tcp" || echo "[WARN] Port $port_arg not currently allowed."
    ufw reload
    ;;

  rebuild|*)
    echo "[INFO] Resetting UFW rules..."
    ufw --force reset
    ufw default deny incoming
    ufw default allow outgoing

    for port in "${ports[@]}"; do
      ufw allow "${port}/tcp"
      echo "[INFO] Port ${port}/tcp allowed."
    done

    if [[ "$remote_exec" == true ]]; then
      ufw allow ssh
      echo "[INFO] SSH access preserved."
    fi

    ufw --force enable
    ufw reload
    ufw status verbose
    ;;
esac

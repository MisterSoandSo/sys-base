#!/usr/bin/env bash
set -euo pipefail

# ========================================
# System Update Script with Logging + Quiet Mode
# ========================================

LOGDIR="/var/log/system_updates"
mkdir -p "$LOGDIR"
LOGFILE="$LOGDIR/system_update-$(date +%Y-%m-%d-%H%M%S).log"

# --- Colors ---
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# --- Parse arguments ---
QUIET=false
for arg in "$@"; do
  case $arg in
    -q|--quiet)
      QUIET=true
      shift
      ;;
    *)
      echo "Usage: $0 [--quiet|-q]"
      exit 1
      ;;
  esac
done

# --- Root check ---
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# --- Error handler ---
trap '{
  echo "[ERROR] Update failed! Check log: ${LOGFILE}" >&2
  if [ "$QUIET" = false ]; then
    echo -e "${RED}[ERROR] Update failed! Check log: ${LOGFILE}${RESET}" >&2
  fi
}' ERR

# --- Logging helpers ---
log_step() {
  local message="$1"
  if [ "$QUIET" = false ]; then
    echo -e "${YELLOW}${message}${RESET}"
  fi
  echo "=== ${message} ===" >>"$LOGFILE"
}

log_done() {
  local message="$1"
  if [ "$QUIET" = false ]; then
    echo -e "${GREEN}${message}${RESET}"
  fi
  echo "[OK] ${message}" >>"$LOGFILE"
}

# --- Script starts ---
if [ "$QUIET" = false ]; then
  echo -e "${YELLOW}System update started at $(date)${RESET}"
  echo "Logging to: $LOGFILE"
  echo
fi

log_step "Updating package index..."
apt update >>"$LOGFILE" 2>&1
log_done "Package index updated."

log_step "Upgrading installed packages..."
apt full-upgrade -y >>"$LOGFILE" 2>&1
log_done "Installed packages upgraded."

log_step "Removing unused packages..."
apt autoremove -y >>"$LOGFILE" 2>&1
log_done "Unused packages removed."

log_step "Cleaning up package cache..."
apt clean >>"$LOGFILE" 2>&1
log_done "Package cache cleared."

if [ "$QUIET" = false ]; then
  echo
  echo -e "${YELLOW}System update complete.${RESET}"
  echo -e "Log saved at: ${LOGFILE}"
else
  echo "System update completed successfully at $(date)" >>"$LOGFILE"
fi

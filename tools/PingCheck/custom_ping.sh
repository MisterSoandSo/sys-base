#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =====================================================
#  Simple Network Tracker
#  Usage: ./track.sh <ip_list.txt> [--fast] [--count N]
# =====================================================

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <ip_list.txt> [--fast] [--count N]"
  exit 1
fi

file=$1
shift || true

# Default options
fast_mode=false
ping_count=1

# Parse optional flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --fast) fast_mode=true ;;
    --count)
      shift
      ping_count=${1:-1}
      ;;
    *) echo "[WARN] Unknown option: $1" ;;
  esac
  shift
done

# Remove DOS line endings if needed
sed -i 's/\r$//' "$file"

echo "=== Network Scan Started: $(date) ==="
echo "Using file: $file"
echo

online=0
offline=0

# Function to ping one host
check_host() {
  local host=$1
  if ping -c "$ping_count" -W 1 "$host" &>/dev/null; then
    echo -e "[\e[32mONLINE\e[0m]  $host"
    ((online++))
  else
    echo -e "[\e[31mOFFLINE\e[0m] $host"
    ((offline++))
  fi
}

export -f check_host
export ping_count

if [[ "$fast_mode" == true ]]; then
  echo "[INFO] Fast mode enabled — running parallel checks..."
  cat "$file" | xargs -P 10 -n 1 bash -c 'check_host "$@"' _
else
  while IFS= read -r host; do
    [[ -z "$host" ]] && continue
    check_host "$host"
  done < "$file"
fi

echo
echo "=== Scan Complete ==="
echo "Online:  $online"
echo "Offline: $offline"

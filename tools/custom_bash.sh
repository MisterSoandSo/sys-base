#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

usage() {
  cat <<EOF
Usage: $0 [-f|--force] <path/to/script.sh>
  -f, --force   Overwrite existing file
EOF
  exit 1
}

# parse args
FORCE=false
TARGET=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--force) FORCE=true; shift ;;
    -h|--help) usage ;;
    *) TARGET="$1"; shift ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "[ERROR] Missing target filename."
  usage
fi

# Resolve to absolute path (without following symlinks)
TARGET_ABS="$(cd "$(dirname "$TARGET")" && pwd)/$(basename "$TARGET")"

# Safety: refuse obviously dangerous targets
case "$TARGET_ABS" in
  /|/etc/*|/bin/*|/sbin/*|/usr/bin/*|/usr/sbin/*)
    echo "[ERROR] Refusing to create/overwrite files in system directories: $TARGET_ABS" >&2
    exit 2
    ;;
esac

# Prevent accidental overwrite
if [[ -e "$TARGET_ABS" && "$FORCE" = false ]]; then
  echo "[ERROR] File already exists: $TARGET_ABS"
  echo "Run with -f or --force to overwrite."
  exit 3
fi

# Ensure parent directory exists
mkdir -p "$(dirname "$TARGET_ABS")"

# Create the file atomically (write to temp then move)
TMPFILE="$(mktemp "${TARGET_ABS}.tmp.XXXXXX")"
trap 'rm -f "$TMPFILE"' EXIT

cat >"$TMPFILE" <<'BASH_TEMPLATE'
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# DESCRIPTION:
# Short description of what this script does.

usage() {
  echo "Usage: $(basename "$0") [options]"
  exit 1
}

main() {
  # Your code here
  echo "Hello from $(basename "$0")"
}

main "$@"
BASH_TEMPLATE

# install file with safe perms
chmod 0755 "$TMPFILE"
mv -f "$TMPFILE" "$TARGET_ABS"
trap - EXIT

echo "[OK] Created: $TARGET_ABS"
ls -al "$TARGET_ABS"

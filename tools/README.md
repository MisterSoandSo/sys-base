# Custom Tools

### Custom_Bash
Creates a new, executable Bash script from a safe template.
It validates the target path, prevents accidental overwrites, and avoids writing to system directories.

```bash
./custom_bash.sh [-f|--force] <path/to/script.sh>
```

---
### CustomPing 
Check if device is online in the network.

---
## Custom_Update
A safe, automated Linux update script that refreshes packages, upgrades the system, removes unused files, and logs every action. Supports interactive color output or quiet mode for cron jobs. Designed for Debian-based systems to maintain reliability with clear logging and minimal manual input.

Manual Activation:
```bash
sudo ./custom_update.sh

✓ Package index updated.
✓ Installed packages upgraded.
✓ System update complete.

```

Cron Job:
> Runs every Sunday at 3 AM, writes full logs in `/var/log/system_updates/`
```bash
0 3 * * 0 /usr/local/bin/custom_update.sh --quiet
```
---


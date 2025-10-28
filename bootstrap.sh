#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "[INFO] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[INFO] Disabling Wi-Fi interfaces..."
for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -E '^wl'); do
  echo "[INFO] Disabling $iface"
  sudo ip link set "$iface" down || echo "[WARN] $iface not found or already down."
done

echo "[INFO] Installing dependencies..."
sudo apt install -y curl ca-certificates gnupg lsb-release tmux glances duf rsync watch

echo "[INFO] Setting up Cloudflare repository..."
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-archive-keyring.gpg] https://pkg.cloudflare.com/cloudflared any main" | \
  sudo tee /etc/apt/sources.list.d/cloudflared.list

sudo apt update
sudo apt install -y cloudflared

echo "[INFO] Installing Docker..."
if ! command -v docker &>/dev/null; then
  curl -fsSL https://get.docker.com | sudo sh
else
  echo "[INFO] Docker already installed."
fi

sudo usermod -aG docker "$USER"
echo "[INFO] Added $USER to docker group. Log out and back in to apply."

sudo systemctl enable --now docker

echo "[INFO] Installing Portainer..."
sudo docker volume create portainer_data >/dev/null 2>&1 || true
if sudo docker ps -a --format '{{.Names}}' | grep -q '^portainer$'; then
  echo "[INFO] Portainer already running."
else
  sudo docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
fi

echo "[INFO] Setup complete!"

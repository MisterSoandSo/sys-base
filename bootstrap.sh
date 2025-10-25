#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "[INFO] Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "[INFO] Disabling Wi-Fi interface (assuming Ethernet in use)..."
if ip link show wlan0 &>/dev/null; then
  sudo ip link set wlan0 down || echo "[WARN] wlan0 not found or already down."
fi

echo "[INFO] Installing core utilities..."
sudo apt install -y \
  tmux glances duf rsync watch cloudflared curl ca-certificates gnupg lsb-release

echo "[INFO] Setting up Docker..."
if ! command -v docker &>/dev/null; then
  curl -fsSL https://get.docker.com | sudo sh
else
  echo "[INFO] Docker already installed."
fi

# Enable non-root Docker access
sudo usermod -aG docker $USER

echo "[INFO] Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[INFO] Installing Portainer..."
sudo docker volume create portainer_data || true

# Install Portaniner
sudo docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo "[INFO] Setup complete!"


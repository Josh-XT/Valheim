#!/bin/bash
sudo ufw allow 2456/udp
sudo ufw allow 2457/udp
sudo ufw allow 2458/udp
sudo ufw allow 27060/udp
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
sudo service docker start
# Check if Midgard.db and Midgard.fwl exist
if [ ! -f "config/worlds/Midgard.db" ] || [ ! -f "config/worlds/Midgard.fwl" ]; then
  # If they don't, copy Midgard.db.old and Midgard.fwl.old from config/worlds
  cp config/worlds/Midgard.db.old config/worlds/Midgard.db
  cp config/worlds/Midgard.fwl.old config/worlds/Midgard.fwl
fi

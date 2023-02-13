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
GITHUB_REPO=$(grep "GITHUB_REPO" .env | cut -d '=' -f2)
GITHUB_BRANCH=$(grep "GITHUB_BRANCH" .env | cut -d '=' -f2)
GITHUB_USER=$(grep "GITHUB_USER" .env | cut -d '=' -f2)
GITHUB_PASSWORD=$(grep "GITHUB_PASSWORD" .env | cut -d '=' -f2)
WORLD_NAME=$(grep "WORLD_NAME" .env | cut -d '=' -f2)
# Add a cron job to backup the world every hour to GitHub repository
(crontab -l ; echo "0 * * * * cd $HOME/Valheim/ && git add . && git commit -a -m 'Automatic Backup' && git push --force https://$GITHUB_USER:$GITHUB_PASSWORD@$GITHUB_REPO $GITHUB_BRANCH") | crontab -
# Check if "$WORLD_NAME.db" and "$WORLD_NAME.fwl" exist
if [ ! -f "$WORLD_NAME.db" ] || [ ! -f "$WORLD_NAME.fwl" ]; then
  # If they don't, copy "$WORLD_NAME.db.old" and "$WORLD_NAME.fwl.old" from config/worlds
  cp config/worlds/"$WORLD_NAME.db.old" "$WORLD_NAME.db"
  cp config/worlds/"$WORLD_NAME.fwl.old" "$WORLD_NAME.fwl"
fi

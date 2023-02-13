# Valheim Game Server
Using [lloesche's docker container](https://hub.docker.com/r/lloesche/valheim-server), this is just a quick setup with our world with docker-compose.  This setup assumes that the server that it is being installed on is a fresh ``Ubuntu 22.04.1 Server`` that does not have Docker installed yet.

I recommend forking this repository if you want to use this on your own server so that you can update the instructions for your own server/world.

## Step 1 - Set up Firewall Rules
Open network firewall ports 2456, 2457, 2458, 27060 and forward to the server's IP address.

## Step 2 - Install Dependencies

```
sudo apt install -y git
git clone https://github.com/Josh-XT/Valheim.git
cd Valheim
sudo chmod 755 ./ServerSetup.sh
sudo ./ServerSetup.sh
```

## Step 3 - Set up environment file
Create a ``.env`` file in the Valheim directory with the following content:

```
SERVER_NAME=XT
WORLD_NAME=Midgard
SERVER_PASS=PASSWORD
SERVER_PUBLIC=false
TZ=America/New_York
BACKUPS=true
BACKUPS_CRON=30 * * * *
BACKUPS_MAX_AGE=1
ADMINLIST_IDS=76561197973374722 76561197987529611 76561198392805374
PERMITTEDLIST_IDS=76561197973374722 76561197987529611 76561198392805374
```

## Step 4 - Start the server
```
sudo docker-compose up -d
```

## Step 5 - Schedule Backups

This will set your server to back up to your GitHub repository.

Run the following in the terminal:

```
crontab -e
```

[Set up a GitHub password token here](https://github.com/settings/tokens?type=beta) if you don't already have one, that will be used to replace the "PASSWORD" below.

Add the following line to the bottom of the file after replacing my repository URL and login information with your own.

```
0 * * * * cd $HOME/Valheim/ && git add . && git commit -a -m "Automatic Backup" && git push --force https://josh-xt:PASSWORD@github.com/Josh-XT/Valheim.git main
```
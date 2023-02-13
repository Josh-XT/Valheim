# Valheim Game Server
Using [lloesche's docker container](https://hub.docker.com/r/lloesche/valheim-server), this is just a quick setup with our world with docker-compose.  

This setup assumes that the server that it is being installed on is a fresh ``Ubuntu 22.04.1 Server`` that does not have Docker installed yet.

I recommend forking this repository if you want to use this on your own server so that you can update the instructions for your own server/world.  If you fork the repository and follow the instructions below, your world will automatically back up to your GitHub repository hourly.

## Step 1 - Set up Firewall Rules
Open network firewall ports 2456, 2457, 2458, 27060 and forward to the server's IP address.

## Step 2 - Clone my repository
Replace my repository with your URL of your forked repository.

```
sudo apt install -y git
git clone https://github.com/Josh-XT/Valheim.git
cd Valheim
cp example.env .env
```

## Step 3 - Set up environment file
**Edit the ``.env`` file and replace the environment variables to be set to your world and GitHub repository for backups.**

Replace ``SERVER_NAME`` with the name you would like your server to be displayed as.

Change ``WORLD_NAME`` to whatever your world's name is.  Ours is Midgard.  If you change this, you'll need to copy your own world files to the ``config/worlds`` folder.

Replace ``SERVER_PASS`` with whatever password you want to be on the server.

Change ``SERVER_PUBLIC`` if you want your server to be public.  Ours is private.

Replace ``GITHUB_REPO`` with your GitHub repository that you forked from this one.

Replace ``GITHUB_BRANCH`` with the branch you're using, if you don't know this, use ``main`` like the example has.

Replace ``GITHUB_USER`` with your GitHub username.

Replace ``GITHUB_PASSWORD`` with your personal access token.  [Set up a GitHub personal access token](https://github.com/settings/tokens?type=beta) if you don't already have one.

Replace or remove the lines with ``ADMINLIST_IDS`` and ``PERMITTEDLIST_IDS`` with you and friends Steam IDs to add access and admin.

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
GITHUB_REPO=github.com/Josh-XT/Valheim.git
GITHUB_BRANCH=main
GITHUB_USER=josh-xt
GITHUB_PASSWORD=PASSWORD
```

For more information on environment variables that can be used, visit [lloesche's docker container documentation.](https://hub.docker.com/r/lloesche/valheim-server)

## Step 4 - Install dependencies
**This will not work if you do not update your ``.env`` file above properly! Make sure that it is correct before you run it.**

```
sudo chmod +x ./ServerSetup.sh
sudo ./ServerSetup.sh
```

## Step 5 - Start the server

```
sudo docker-compose up -d
```
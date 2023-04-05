#!/usr/bin/env bash

#------------------------------------------------------------------------------
# SSH Authorized Keys Configuration
#------------------------------------------------------------------------------
mkdir -p /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
touch /home/ubuntu/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
%{ for k in ssh_keys ~}
echo "${k}" >> /home/ubuntu/.ssh/authorized_keys
%{ endfor ~}

#------------------------------------------------------------------------------
# Strong DM
#------------------------------------------------------------------------------
apt-get -qq update && apt-get install -qq unzip
cd /usr/local/bin
URL="$(curl -s 'https://app.strongdm.com/release?os=linux&arch=arm64&software=sdm-cli&variant=&version=truemark' | jq -r .url)"
curl -J -O -L "$URL" && unzip sdmcli* && rm -f sdmcli*
export SDM_RELAY_TOKEN="${token}"
./sdm install --relay --user ubuntu

#! /bin/sh
# Copyright (C) 2016, Siemens AG, Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
# SPDX-License-Identifier:	Apache-2.0
# Install kernelci backend

cd $HOME && mkdir git-repos && cd git-repos
git clone https://github.com/kernelci/kernelci-backend-config.git kernelci-backend
cp /vagrant/config/secrets-backend.yml kernelci-backend/secrets.yml

# Fixme: Don't let ansible try to create the file in the first place.
if [ ! -d /etc/sysfs.d/ ]; then
    sudo mkdir /etc/sysfs.d
fi
sudo touch /etc/sysfs.d/99-thp-defrag.conf

# TODO: This asks for a sudo password, which we need to provide non-interactively
cd kernelci-backend
ansible-playbook -i hosts site.yml -l local -c local -K -e "@secrets.yml" \
                 -e "@secrets.yml" --skip-tags=backup,firewall,web-server

# Make sure the backend REST service started to listen  on port 8888 before
# trying to obtain an admin session token
while netstat -lnt | awk '$4 ~ /:8888$/ {exit 1}'; do sleep 2; done

# Obtain the session token with admin privileges.
MASTER_KEY=`cat /vagrant/config/secrets-backend.yml | grep master_key | \
           awk '{print $2;}'`
TOKEN=`python /vagrant/scripts/get_admin_token.py ${MASTER_KEY}`
echo $TOKEN > $HOME/backend-admin-token.txt

# Copyright (C) 2016, Siemens AG, Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
# SPDX-License-Identifier:	Apache-2.0
sudo DEBIAN_FRONTEND=noninteractive apt-get -qqy update
sudo DEBIAN_FRONTEND=noninteractive apt-get -qqy install git python-pip python-dev \
                     python-concurrent.futures python-tornado gcc-arm-linux-gnueabi \
                     libffi-dev libyaml-dev libssl-dev
sudo pip install ansible markupsafe

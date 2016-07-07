#!/bin/bash
set -e

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
apt-get update
apt-get -f install
apt-get install -y build-essential git libssl-dev libreadline-dev libncurses5-dev zlib1g-dev m4 curl wx-common libwxgtk3.0-dev autoconf
apt-get install -y esl-erlang elixir
mkdir -p /home/vagrant/bin
chown -R vagrant:vagrant /home/vagrant/bin
echo 'export PATH=$HOME/bin:$PATH' >> /home/vagrant/.bashrc

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

apt-get -y install postgresql postgresql-client

su - postgres -c "createuser vagrant && psql -c \"ALTER user vagrant WITH PASSWORD 'vagrant' CREATEDB\""

su - vagrant -c "mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez"

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

add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
wget --quiet -O - https://postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - 
apt-get update
apt-get -y install postgresql-9.4 postgresql-client-9.4

su - postgres -c "createuser vagrant && psql -c \"ALTER user vagrant WITH PASSWORD 'vagrant' CREATEDB\""

su - vagrant -c "mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez"

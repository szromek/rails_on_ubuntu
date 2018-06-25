#!/bin/bash

print_step() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n------------$fmt-------------\n" "$@"
}

sudo apt-get update

# Install and setup PostgreSQL ################################################

print_step "Checking Postgres installation"
if ! dpkg -s postgresql; then
  sudo apt-get install -y postgresql postgresql-contrib
  sudo service postgresql start
else
  echo "OK"
fi

# Install Asdf ###############################################################

print_step "Checking Asdf version manager"
if ! dpkg -s asdf; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
  echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
  echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  # Restart bash
  . .bashrc

  asdf plugin-add ruby
  asdf plugin-add nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
else
  echo "OK"
fi


# Install Redis ###############################################################

# print_step "Checking Redis installation"
# if ! dpkg -s redis-server; then
#   sudo apt-get install -y redis-server
# else
#   echo "OK"
# fi

# Install Node.js #############################################################

# print_step "Checking for Node.js"
# if ! node --version; then
#   asdf install nodejs 10.5.0
#   asdf global nodejs 10.5.0
# else
#   echo 'OK'
# fi

# Install Yarn #############################################################

# print_step "Checking for Yarn"
# if ! yarn --v; then
#   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#   echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
#   sudo apt-get update && sudo apt-get install -y yarn
# else
#   echo 'OK'
# fi


# Ruby and Version Manager ####################################################

# print_step "Checking for Ruby"
# if ! ruby -v; then
#   asdf install ruby 2.5.1
#   asdf global ruby 2.5.1
#   # Capybara dependencies
#   sudo apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
# else
#   echo 'OK'
# fi


# Install Heroku CLI ##########################################################

# print_step "Checking for Heroku CLI"
# if ! heroku --version; then
#   wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
# else
#   echo 'OK'
# fi

# Install Ngrok exposer ######################################################

# print_step "Checking for Ngrok"
# if ! ngrok; then
#   sudo apt install -y unzip
#   wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
#   sudo unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin
#   rm -rf ngrok-stable-linux-amd64.zip
# else
#   echo "OK"
# fi

# Install Elasticsearch #################################################

# print_step "Elasticsearch"
# if ! systemctl is-active elasticsearch.service; then
#   sudo apt-get install -y default-jre
#   wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
#   echo "Instalating Elasticsearch"
#   sudo dpkg -i elasticsearch-2.3.1.deb
#   sudo systemctl enable elasticsearch.service
# else
#   echo "OK"
# fi


# Cleaning up #################################################################

# print_step "Removing unused software..."
# sudo apt autoremove -y

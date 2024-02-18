#!/bin/bash

# Install Grafana
echo "Installing Grafana..."
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get -y update
sudo apt-get install -y grafana

# Configure Grafana
echo "Configuring Grafana..."
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# Verify Grafana
echo "Verifying Grafana installation..."
sudo systemctl status grafana-server
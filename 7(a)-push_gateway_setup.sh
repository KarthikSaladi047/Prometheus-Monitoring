#!/bin/bash

# Step 1: Install Push Gateway

# Create a directory for Push Gateway
mkdir ~/Pushgateway

# Change into the Push Gateway directory
cd ~/Pushgateway

# Download the latest version of Push Gateway
wget https://github.com/prometheus/pushgateway/releases/download/v1.7.0/pushgateway-1.7.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf pushgateway-1.7.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv pushgateway-1.7.0.linux-amd64 pushgateway

# Step 2: Running Push Gateway as a Service

# Create user push_gateway
sudo useradd push_gateway

# Copy files from Push Gateway setup
sudo cp ~/Pushgateway/pushgateway/pushgateway /usr/local/bin/

# Assign ownership of files to push_gateway user
sudo chown push_gateway:push_gateway /usr/local/bin/pushgateway

# Add systemd service unit file for Push Gateway
cat << EOF | sudo tee /etc/systemd/system/pushgateway.service
[Unit]
Description=Prometheus Pushgateway
Wants=network-online.target
After=network-online.target

[Service]
User=push_gateway
Group=push_gateway
Type=simple
ExecStart=/usr/local/bin/pushgateway

[Install]
WantedBy=multi-user.target
EOF

# Start and enable Push Gateway service
sudo systemctl daemon-reload
sudo systemctl enable pushgateway
sudo systemctl start pushgateway

# Step 3: Add Push Gateway as Prometheus target

# Add Push Gateway to prometheus.yml
sudo bash -c 'cat << EOF >> /etc/prometheus/prometheus.yml
  - job_name: 'push_gateway'
    honor_labels: true
    static_configs:
      - targets: ['localhost:9091']
EOF'

# Restart Prometheus
sudo systemctl restart prometheus
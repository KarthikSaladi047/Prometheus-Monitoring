#!/bin/bash

# Step 1: Install Blackbox Exporter

# Create a directory for Blackbox Exporter
mkdir ~/Blackbox

# Change into the Blackbox Exporter directory
cd ~/Blackbox

# Download the latest version of Blackbox Exporter
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.24.0/blackbox_exporter-0.24.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf blackbox_exporter-0.24.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv blackbox_exporter-0.24.0.linux-amd64 blackbox

# Step 2: Configure Blackbox Exporter

# Edit the blackbox.yml file to configure probes
cat << EOF | sudo tee ~/Blackbox/blackbox/blackbox.yml
modules:
  dns_google:
    prober: dns
    timeout: 15s
    dns:
      transport_protocol: tcp
      query_name: "www.google.com"
  http_redflagdeals:
    prober: http
    http:
      preferred_ip_protocol: "ip4"
      fail_if_body_not_matches_regexp:
        - "sale"
EOF

# Step 3: Running Blackbox Exporter as a Service

# Create user blackbox_exporter
sudo useradd blackbox
sudo mkdir /etc/blackbox/

# Copy files from Blackbox Exporter setup
sudo cp ~/Blackbox/blackbox/blackbox_exporter /usr/local/bin/
sudo cp ~/Blackbox/blackbox/blackbox.yml /etc/blackbox/

# Assign ownership of files to blackbox user
sudo chown blackbox:blackbox /usr/local/bin/blackbox_exporter
sudo chown -R blackbox:blackbox /etc/blackbox/

# Add systemd service unit file for Blackbox Exporter
cat << EOF | sudo tee /etc/systemd/system/blackbox.service
[Unit]
Description=Blackbox
Wants=network-online.target
After=network-online.target

[Service]
User=blackbox
Group=blackbox
Type=simple
ExecStart=/usr/local/bin/blackbox_exporter --config.file=/etc/blackbox/blackbox.yml --web.listen-address="0.0.0.0:9115"

[Install]
WantedBy=multi-user.target
EOF

# Start and enable Blackbox Exporter service
sudo systemctl daemon-reload
sudo systemctl enable blackbox
sudo systemctl start blackbox

# Step 4: Add Blackbox Exporter as Prometheus target

# Add Blackbox Exporter to prometheus.yml
sudo bash -c 'cat << EOF >> /etc/prometheus/prometheus.yml
  - job_name: 'blackbox'
    metrics_path: /probe
    params:
      module:
        - dns_google
        - http_redflagdeals
    static_configs:
      - targets: ['8.8.8.8', 'https://www.redflagdeals.com']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115
EOF'

# Restart Prometheus
sudo systemctl restart prometheus
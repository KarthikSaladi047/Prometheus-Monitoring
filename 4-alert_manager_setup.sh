#!/bin/bash

# Step 1: Install Alert Manager

# Create a directory for Alertmanager
mkdir ~/Alert_Manager

# Change into the Prometheus directory
cd ~/Alert_Manager

# Download the latest version of Prometheus
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf alertmanager-0.26.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv alertmanager-0.26.0.linux-amd64 alertmanager

# Create user alertmanager
sudo useradd alertmanager

# Create directories
sudo mkdir /var/lib/alertmanager
sudo mkdir /etc/alertmanager

# Copy files from Alert Manager setup
sudo cp alertmanager/alertmanager /usr/local/bin/
sudo cp alertmanager/alertmanager.yml  /etc/alertmanager/

# Assign ownership of files to alertmanager user
sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager 
sudo chown alertmanager:alertmanager /var/lib/alertmanager
sudo chown -R alertmanager:alertmanager /etc/alertmanager/*

# Add systemd service unit file for Prometheus.
sudo sh -c 'cat > /etc/systemd/system/alertmanager.service <<EOF
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
WorkingDirectory=/etc/alertmanager/
ExecStart=/usr/local/bin/alertmanager --config.file /etc/alertmanager/alertmanager.yml --storage.path /var/lib/alertmanager/

[Install]
WantedBy=multi-user.target
EOF'

# Run the Alert Manager service
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager
sudo systemctl status alertmanager

# Create a configuration file for alerting rules
cat << EOF | sudo tee /etc/prometheus/rules1.yml
groups:
- name: alerts_1
  rules:
  - alert: HighCPULoad
    expr: 100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 90
    for: 5m
    labels:
      severity: page
    annotations:
      summary: High CPU Load
  - alert: LowMemory
    expr: (avg(node_memory_MemFree_bytes) / avg(node_memory_MemTotal_bytes)) * 100 < 10
    for: 5m
    labels:
      severity: page
    annotations:
      summary: Low Memory
EOF

# Step 3: Configure Alerts

# Edit Prometheus configuration file to include Alertmanager configuration
sudo sed -i '/^alerting:$/,+5d' /etc/prometheus/prometheus.yml
sudo sed -i '/# Alertmanager configuration/a\alerting:\n  alertmanagers:\n    - static_configs:\n        - targets:\n          - localhost:9093' /etc/prometheus/prometheus.yml
sudo sed -i '/rule_files:/a \  - \/etc\/prometheus\/rules1.yml' /etc/prometheus/prometheus.yml

# Restart Prometheus to apply new configuration
sudo systemctl restart prometheus

# Update the Alertmanager configuration file with basic configurations
cat << EOF | sudo tee /etc/alertmanager/alertmanager.yml
route:
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 1h
  receiver: 'web.hook'
receivers:
  - name: 'web.hook'
    webhook_configs:
      - url: 'http://127.0.0.1:5001/'
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
EOF

# Restart Alert Manager to apply new configuration
sudo systemctl restart alertmanager

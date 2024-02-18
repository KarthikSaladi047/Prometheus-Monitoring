#!/bin/bash

# Section 1: Install Prometheus
echo "Installing Prometheus..."
mkdir ~/Prometheus
cd ~/Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
tar -xvf prometheus-2.30.3.linux-amd64.tar.gz
mv prometheus-2.30.3.linux-amd64 prometheus

# Section 2: Configure Prometheus
echo "Configuring Prometheus..."
cat > ~/Prometheus/prometheus.yml <<EOF
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
EOF

# Section 3: Running Prometheus as a Service
echo "Running Prometheus as a service..."

sudo useradd prometheus
cd ~/Prometheus
sudo mkdir /var/lib/prometheus/
sudo mkdir /etc/prometheus/
sudo cp prometheus/prometheus /usr/local/bin
sudo cp prometheus/promtool /usr/local/bin
sudo cp -r prometheus/consoles /etc/prometheus/
sudo cp -r prometheus/console_libraries /etc/prometheus
sudo cp prometheus/prometheus.yml /etc/prometheus/

sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus/


sudo sh -c 'cat > /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Section 4: Verify Prometheus
echo "Verifying Prometheus installation..."
sudo systemctl status prometheus

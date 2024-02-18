#!/bin/bash

# Download Node Exporter
echo "Downloading Node Exporter..."
mkdir ~/Node_Exporter
cd ~/Node_Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz

# Extract Node Exporter
echo "Extracting Node Exporter..."
tar -xvf node_exporter-1.2.2.linux-amd64.tar.gz

# Move Node Exporter binary to /usr/local/bin
echo "Moving Node Exporter binary..."
sudo mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/


# Create a user for Node Exporter
echo "Creating user for Node Exporter..."
sudo useradd -rs /bin/false node_exporter

# Assign ownership of files to node_exporter user
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter 

# Create a systemd service file for Node Exporter
echo "Creating systemd service file for Node Exporter..."

sudo sh -c 'cat > /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd manager configuration
echo "Reloading systemd manager configuration..."
sudo systemctl daemon-reload

# Start Node Exporter service
echo "Starting Node Exporter service..."
sudo systemctl start node_exporter

# Enable Node Exporter service to start on boot
echo "Enabling Node Exporter service to start on boot..."
sudo systemctl enable node_exporter

# Verify Node Exporter status
echo "Verifying Node Exporter status..."
sudo systemctl status node_exporter

# Add Node Exporter as Prometheus target

# Add Node Exporter to prometheus.yml
sudo bash -c 'cat << EOF >> /etc/prometheus/prometheus.yml
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
EOF'

# Restart Prometheus
sudo systemctl restart prometheus
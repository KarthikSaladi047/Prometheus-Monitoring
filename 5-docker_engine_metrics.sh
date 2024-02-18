#!/bin/bash

# Step 1: Install Docker

# Update the package index
sudo apt update

# Install Docker
sudo apt install docker.io -y

# Step 2: Enable Docker Metrics

# Create a daemon.json file with required configurations
cat << EOF | sudo tee /etc/docker/daemon.json
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
EOF

# Restart Docker
sudo systemctl restart docker

# Step 3: Configure Prometheus

# Edit prometheus.yml to include Docker as a scraping target
sudo tee -a /etc/prometheus/prometheus.yml <<EOF

  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']
EOF

# Restart Prometheus to apply the new configuration
sudo systemctl restart prometheus
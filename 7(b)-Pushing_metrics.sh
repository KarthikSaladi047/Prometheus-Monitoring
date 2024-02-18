#!/bin/bash

# Step 1: Create the Python script push_register.py
echo "from prometheus_client import CollectorRegistry, Gauge, push_to_gateway

registry = CollectorRegistry()

g = Gauge('job_last_success_unixtime', 'Last time a batch job successfully finished', registry=registry)

g.set_to_current_time()

push_to_gateway('localhost:9091', job='batchA', registry=registry)" > ~/Pushgateway/push_register.py

# Step 2: Install required Python packages
sudo apt install -y python3-pip
pip install -y prometheus-client

# Step 3: Create a cron job
(crontab -l ; echo "*/5 * * * * /bin/mktemp /tmp/push-XXXXX && /usr/bin/python3 /home/$USER/Pushgateway/push_register.py > /dev/null 2>&1") | crontab -
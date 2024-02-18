# Monitoring with Prometheus 🔥

Monitoring and alerting are like the guardians of your digital realm, ensuring the health, performance, and reliability of your systems. In the vast landscape of technology, where systems are dynamic and complexities abound, the need for vigilant oversight has never been more crucial. This is where monitoring and alerting step in as the unsung heroes of digital operations.

![303099163-9bd52ab0-c83f-4967-a1cd-c0964bb71b3b](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/36df7b71-f5ab-4858-bd70-ddf8fb108140)

### Monitoring:🔎
Imagine, your digital infrastructure as a living organism. Monitoring is the constant watchful eye that observes every heartbeat and pulse. It tracks performance metrics, system resource utilization, and the overall well-being of your applications and services. By collecting and analyzing data in real time, monitoring provides a comprehensive view of your system's health.

#### Why Monitoring Matters:
- Proactive Issue Identification: Monitoring allows you to identify potential issues before they escalate into critical problems. By tracking key metrics, you gain insights into trends and anomalies that might indicate potential issues.
- Optimizing Performance: Understanding how your systems perform under different conditions enables you to optimize resources. Monitoring helps you pinpoint bottlenecks, optimize workflows, and ensure efficient resource utilization.
- Enhancing User Experience: Users demand a seamless experience. Monitoring helps you detect and resolve issues that could impact user satisfaction, such as slow response times or service outages.

### Alerting:🚨
Now, imagine monitoring as the watchtower, and alerting as the vigilant guardian that raises the alarm when danger approaches. Alerting takes the insights gained from monitoring and turns them into actionable notifications.

#### Why Alerting Matters:
- Swift Response to Issues: Alerting ensures that the right people are notified immediately when a predefined threshold is breached. This rapid response is crucial for minimizing downtime and mitigating potential damage.
- Preventing Catastrophes: By receiving alerts for abnormal conditions, you can address issues before they escalate into critical failures. This proactive approach is key to preventing catastrophic system failures.
- Maintaining Service Levels: For businesses relying on digital services, maintaining consistent service levels is paramount. Alerting helps you uphold service level agreements (SLAs) and ensures uninterrupted operations.

In summary, monitoring and alerting empower you to maintain reliable, stable services, react swiftly to issues, and make confident changes.🚀

---
## 🔭 Prometheus Architecture

![303097014-42846201-54e4-4090-943f-b88fb78fbfb3](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/e0ea86bb-595a-4a14-9cb1-95015fe8530a)

The major component of the Prometheus is the Prometheus server.

- The Prometheus server contains Retrieval, TSDB and HTTP servers.
- **Retrieval:** It sends the HTTP pull request to the target's endpoints and collects the data (scrapes the metric data).
- **TSDB:** A time series database to store the metric data.
- **HTTP Server:** Exposes an HTTP API for other components to access the metrics stored by Prometheus. Provides a dashboard that is useful for executing metric queries and getting various status info for visualization.
- **Exporters:** Exporter which fetches metrics from targets and coverts to the correct format of Prometheus expects and exposes that data at metrics endpoints.
- **Pushgateway:** It's for short-time lived jobs. A batch workload that shuts down when it has finished its work may not give the metrics to the Prometheus server the chance to collect all metrics before it disappears, the batch workload can push its metrics to the Pushgateway which, in turn, exposes those metrics for the Prometheus server to retrieve.
- **Service discovery:** Service discovery allows us to find the target endpoint to scrape the metrics.
- **Alertmanager:** processes alerts and routes them to receivers that constitute the communication medium to the on-call engineers.
- **PromQL:** It is a powerful query language used for querying. It allows users to retrieve, filter, aggregate and transform metrics to gain insights into system performance and behaviour. PromQL query expression which used to set the alert rule for the alerting system.
_ **Data Visualization:** Help in the visualization of metrics data into graphs and other forms. Grafana is an open-source visualization layer that has become the default solution for viewing Prometheus metrics.
---

## ⭐️ Project Intro

In today's computing landscape, maintaining the health and performance of applications and infrastructure is crucial for ensuring reliability and optimal user experience. The Monitoring and Alerting System project, executed on a VirtualBox VM, utilizes industry-standard tools like Prometheus, Grafana, and Alertmanager to provide a robust solution for collecting, visualizing, and alerting on key metrics.

### Objective
The primary objective of this project is to develop a comprehensive monitoring and alerting system that enables real-time visibility into the health and performance of applications and infrastructure components. By harnessing the power of Prometheus for metric collection, Grafana for visualization, and Alertmanager for alerting, the system empowers users to gain actionable insights and proactively respond to potential issues.

### Features
- **Metric Collection:** Utilize Prometheus to scrape metrics from applications, services, and infrastructure components.
- **Visualization:** Create intuitive dashboards in Grafana to monitor key metrics and performance trends.
- **Alerting:** Define alerting rules in Prometheus and configure alerts in Alertmanager to notify stakeholders of critical issues.
- **Node Exporter:** Set up Node Exporter to collect system-level metrics from target hosts for comprehensive monitoring.

### Technologies Used
- **Prometheus:** An open-source monitoring and alerting toolkit designed for reliability and scalability.
- **Grafana:** A leading open-source platform for visualizing time series data and creating interactive dashboards.
- **Alertmanager:** Part of the Prometheus ecosystem, Alertmanager handles alerts sent by client applications and dispatches them to receivers.
- **Node Exporter:** Prometheus exporter for hardware and OS metrics exposed by *NIX kernels.
- **Docker:** Docker is an open platform designed for developing, shipping, and running applications using a concept called containers
- **Blackbox Exporter:** The blackbox exporter allows the probing of endpoints over HTTP, HTTPS, DNS, TCP, ICMP, and gRPC. It provides metrics about latencies for HTTP requests and DNS as well as statistics about SSL certificate expiration.
- **Push Gateway:** The Pushgateway exists to allow ephemeral and batch jobs to expose their metrics to Prometheus.

![303105394-87d6d819-8e58-415c-8527-9e2fb6f4aeb1](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/f8775486-478e-4bda-a270-a9a9e398505d)

Start monitoring your systems today and stay ahead of potential issues with the Monitoring and Alerting System!

---

## 1️⃣ Setting up a VM:

### Step 1: Installing Packages:

- Download and install Virtualbox from https://www.virtualbox.org/wiki/Downloads.
- Download a Linux OS - In this project I am using Ubuntu Server, downloading and installing from https://ubuntu.com/download/server.

### Step 2: Create a Linux VM:

- Open Virtualbox and click on new to create a new VM.
- Select the ISO image that we have downloaded previously (ubuntu-22.04.3-live-server-amd64.iso).
- Provide the required details - including name, CPU, Memory, etc details.
- Click on Finish to complete the VM creation process.

That's it! You now have a VM set up on Virtualbox.

Once the VM is up and running, you can access it by ssh into the VM.

![302129631-eee45ef9-f67c-449a-88ed-4b35a1c4b4de](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/1ea92d36-0a03-4877-8d0c-5844cd501f8b)

---

## 2️⃣ Prometheus Setup:

Login to your VM through SSH and follow these steps to download and install Prometheus:

### Step 1: Install Prometheus:

- Execute the following commands:
```
# Create a directory for Prometheus
mkdir ~/Prometheus

# Change into the Prometheus directory
cd ~/Prometheus

# Download the latest version of Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.45.3/prometheus-2.45.3.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf prometheus-2.45.3.linux-amd64.tar.gz 

# Rename the extracted directory for simplicity
mv prometheus-* prometheus
```
Refer: https://prometheus.io/download/#prometheus

### Step 2: Configure Prometheus:

- Edit the prometheus.yml file in the ~/Prometheus/prometheus directory. Use a text editor like Nano or Vim:

```
vim ~/Prometheus/prometheus/prometheus.yml
```
- Add the following configuration to prometheus.yml:

```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```

### Step 3: Run Prometheus (optional):

- Execute the following commands to start Prometheus:

```
# Change into the Prometheus directory
cd ~/Prometheus/prometheus

# Start Prometheus
./prometheus
```
Prometheus will now start scraping metrics from your application based on the configuration.

### Step 4: Running Prometheus as a Service on the VM

- Create user **prometheus**
```
sudo useradd prometheus
```
- Create below directories
```
sudo mkdir /var/lib/prometheus/
sudo mkdir /etc/prometheus/
```
- Copy file from prometheus setup
```
cd ~/Prometheus
sudo cp prometheus/prometheus /usr/local/bin
sudo cp prometheus/promtool /usr/local/bin
sudo cp -r prometheus/consoles /etc/prometheus/
sudo cp -r prometheus/console_libraries /etc/prometheus
sudo cp prometheus/prometheus.yml /etc/prometheus/
```
- Assign ownership of files to prometheus user
```
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus/
```

- Add systemd service unit file for Prometheus.
```
sudo vim /etc/systemd/system/prometheus.service
```
- Add the following and save the file.
```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries --web.enable-lifecycle
[Install]
WantedBy=multi-user.target
```
- Run the Prometheus service
```
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
```
### Step 5: Verify Prometheus:

- Check if the Prometheus is running.
```
sudo systemctl status prometheus
```
![302131300-bfd0aa92-311e-4d0d-bc0b-0a1c3860e8f0](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/a7224c1e-c275-4953-b77d-6348fb8d1147)

- Open your web browser and navigate to http://localhost:9090. You should see the Prometheus web interface. We can use the query interface to check if metrics from our application are being scraped successfully.
  
![302131177-8a1892c6-16d1-4033-bf4c-91673eead38b](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/1acaf774-b9a6-4cea-8be6-f1095163388d)

---

## 3️⃣ Grafana Setup:

Login to your VM through SSH and follow these steps to download and install Grafana:

### Step 1: Install Grafana:

- Execute the following commands
```
# Create a directory for Grafana
mkdir ~/Grafana

# Change into the Grafana directory
cd ~/Grafana

# Add grafana’s required user
sudo apt-get install -y adduser libfontconfig1 musl

# Download & install the latest version of Grafana
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.3.1_amd64.deb
sudo dpkg -i grafana-enterprise_10.3.1_amd64.deb
```
Refer: https://grafana.com/grafana/download

### Step 2: Run Grafana:

- Execute the following commands to start Grafana:

```
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service
```
### Step 3: Verify Grafana:

- Check if the Grafana is running.
```
sudo systemctl status grafana-server
```
![302130944-2c34b909-7581-49c3-9b39-b06114f37e03](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/d80283c9-ec26-4d53-a99f-135b727ed581)

- you can access the Grafana web interface by navigating to http://localhost:3000 in your browser.

![302131333-fc769d92-c100-4c11-97b1-dee5089ab627](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/95ce05dc-b81b-4cba-834e-1dda1e990edd)

### Step 4: Connect Grafana to Prometheus:

- In your browser, go to http://localhost:3000.
- Log in to Grafana using the default credentials (username: admin, password: admin).
- Change your password when prompted.
- Once logged in, click on the "connections" in the left sidebar menu.
- Click on "Data Sources" under the "Connections" section.
- Click on the "Add your first data source" button.
- Choose "Prometheus" from the list of available data sources.
- In the HTTP section, set the URL to http://localhost:9090 (assuming Prometheus is running on the same VM).
- Scroll down and click "Save & Test" to verify the connection.

![302131655-0f41c65e-40ca-4bad-a6d7-7c87e35238d7](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/9a533c2f-9953-46ee-992f-f03a2eafa50a)

Grafana is now connected to Prometheus as a data source.

---

## 4️⃣ Dashboard Creation:

### Step 1: Create a new Dashboard:

In Grafana, click on the "Dashboards" in the left sidebar Menu and then click on Create Dashboard.

### Step 2: Add Panels:

#### Panel 1: CPU Usage
- Click on "Add Visualization".
- Select Prometheus as the data source.
- Choose "Time Series" as the visualization in the left menu.
- Write a Prometheus query for CPU usage, for example: 100 - (avg(irate(process_cpu_seconds_total[5m])) * 100)
- Customize axes, legend, and other settings as needed.
- Click "Apply" to add the panel.
  
#### Panel 2: Memory Usage

- Click on the "Add" Button and select "virtualization".
- Choose "Time Series" or "Gauge" as the visualization.
- Use a Prometheus query for memory usage, for example: 100 - (avg(node_memory_MemFree_bytes) / avg(node_memory_MemTotal_bytes)) * 100
- Adjust settings based on your preference.
- Click "Apply" to add the panel.
  
### Step 3: Organize & Save the Dashboard:

- Arrange the panels on the dashboard by dragging and dropping.
- Click on the save icon in the top menu to save your dashboard.
- Give it a meaningful name.

![302138271-81106dd2-3922-4ee2-9663-1f846a4da8f7](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/94fa8673-df95-4684-89c8-4512f958eeb8)

### Step 4: View and Share:

- Navigate through different time ranges to ensure the dashboard adapts to historical data.
- Use the "Share" feature in Grafana to generate a link or embed code for sharing the dashboard.
  
This is just a basic example. Depending on your application and specific metrics, you can create additional panels, explore different visualizations, and customize the layout to suit your monitoring needs.

---
## 5️⃣ Node Exporter Setup:

Login into your VM through SSH and follow these steps to download and install Node Exporter:

### Step 1: Install Node Exporter:
- Execute the following commands:
```
# Create a directory for Node Exporter
mkdir ~/Node_Exporter

# Change into the Node Exporter directory
cd ~/Node_Exporter

# Download the latest version of Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf node_exporter-1.7.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv node_exporter-* node_exporter
```
Refer: https://prometheus.io/download/#node_exporter

### Step 2: Running Node Exporter as a Service on the VM

- Create user **node_exporter**
```
sudo useradd node_exporter
```
- Copy file from Node Exporter setup
```
cd ~/Node_Exporter
sudo cp node_exporter/node_exporter /usr/local/bin
```
- Add systemd service unit file for Node Exporter.
```
sudo vim /etc/systemd/system/node_exporter.service
```
- Add the following and save the file.
```
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
```
- Run the Node Exporter service
```
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
```
### Step 3: Configure Prometheus:

- Edit the prometheus.yml file in the ~/etc/prometheus/ directory. Use a text editor like Nano or Vim:

```
vim /etc/prometheus/prometheus.yml
```
- Add the following configuration to prometheus.yml to add node_exporter as a scraping target for Prometheus:

```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'
scrape_configs:
- job_name: 'prometheus'
  static_configs:
   - targets: ['localhost:9090']
- job_name: 'node_exporter'
  static_configs:
   - targets: ['localhost:9100']
```
- We need to restart Prometheus so that the new configuration will be applied.
```
sudo systemctl restart prometheus
```
### Step 5: Verify Node Exporter:

- Check if the Node Exporter is running.
```
sudo systemctl status node_exporter
```
![302139891-1214f8dc-29f8-476e-9485-56b63637597a](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/b4054175-37b5-4a31-8f66-c1cbd4d277fb)

- Open your web browser and navigate to http://localhost:9100/metrics. You should see the Node Exporter web interface logging the metrics.

![302139923-e130fd11-a4dc-4c7e-ba94-de528e45102a](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/6348f76a-4a3f-4981-8d63-5a5ef04796a5)

- Now we can see the node metrics in Prometheus.

![303863980-8375f4c1-2354-4b55-b8cb-55ec3f783ea7](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/06abfa86-a5e8-42cf-b055-983f38a2046f)

---

## 6️⃣ Alerting Rules:

Login into your VM through SSH and follow these steps to download and install Alert Manager:

### Step 1: Install Alert Manager:

- Execute the following commands:
```
# Create a directory for Prometheus
mkdir ~/Alert_Manager

# Change into the Prometheus directory
cd ~/Alert_Manager

# Download the latest version of Prometheus
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf alertmanager-0.26.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv alertmanager-* alertmanager
```
Refer: https://prometheus.io/download/#alertmanager

### Step 2: Running Alert Manager as a Service on the VM

- Create user **alertmanager**
```
sudo useradd alertmanager
```
- Create below directories
```
sudo mkdir /var/lib/alertmanager
sudo mkdir /etc/alertmanager
```
- Copy file from Alert Manager setup
```
cd ~/Alert_Manager
sudo cp alertmanager/alertmanager /usr/local/bin/
sudo cp alertmanager/alertmanager.yml  /etc/alertmanager
```
- Assign ownership of files to alertmanager user
```
sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager 
sudo chown -R alertmanager:alertmanager /etc/alertmanager
```

- Add systemd service unit file for Alertmanger.
```
sudo vim /etc/systemd/system/alertmanager.service
```
- Add the following and save the file.
```
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target
[Service]
User=alertmanager
Group=alertmanager
Type=simple
WorkingDirectory=/etc/alertmanager/
ExecStart=/usr/local/bin/alertmanager
--config.file /etc/alertmanager/alertmanager.yml
--storage.path /var/lib/alertmanager/
[Install]
WantedBy=multi-user.target
```
- Run the Alert Manager service
```
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager
```
### Step 3: Verify Alert Manager:

- Check if the Alert Manager is running.
```
sudo systemctl status alertmanager
```
![302143739-ec395c3d-c88a-4834-8099-c6055ad7c134](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/f6c8b219-c5d6-47ec-b12b-a3e0485760d8)

- Open your web browser and navigate to http://localhost:9093. You should see the Alert Manager web interface.

![302143780-d8e851e1-83e8-4718-b325-0848c9be084b](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/8f86b0d1-da04-4284-a9d4-92e9e8ec8abc)

### Step 4: Define Alerting Rules:

- create a /etc/prometheus/rules1.yml configuration file to add alerting rules.
```
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
```
In the above example:

- HighCPULoad: Triggers an alert if the CPU usage is above 90% for more than 5 minutes.

- LowMemory: Triggers an alert if the available memory is below 10% for more than 5 minutes.

### Step 5: Configure Alerts:

- Prometheus can send alerts to Alertmanager, which then handles the notifications. Update your /etc/prometheus/prometheus.yml to include the Alertmanager configuration:
```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']

rule_files:
  - rules1.yml

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093
```
- now restart Prometheus, so that the new configuration will be applied.
```
sudo systemctl restart prometheus
```
### Step 6: Set up Alertmanager:

Update the /etc/alertmanager/alertmanager.yml file with basic configurations. For simplicity, let's use a simple notification through email. Add the following to your alertmanager.yml:

```
global:
  smtp_smarthost: 'smtp.example.com:587'
  smtp_from: 'alertmanager@example.com'
  smtp_auth_username: 'alertmanager@example.com'
  smtp_auth_password: 'your_email_password'

route:
  group_by: ['alertname', 'job']

receivers:
- name: 'email-notifier'
  email_configs:
  - to: 'your-email@example.com'
```
Replace placeholders with your actual email server details.

- now restart Alert Manager, so that the new configuration will be applied.
```
sudo systemctl restart alertmanger
``` 
### Step 7: Test the Alerts:

To test the alerts, you can manually trigger them. For example, stress your system to simulate high CPU usage or low memory conditions.
```
sudo apt-get install stress
stress --cpu 8 --io 4 --vm 2 --timeout 1000
```
Refer: https://pkgs.org/download/stress

### Step 8: View Alerts:

- Access the Prometheus web interface at http://localhost:9090 and You should see active alerts and their status.

![302149774-3f68a58a-5a0a-4683-ae96-d9b7545b6610](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/415a39af-e2a2-46b4-956c-c72c2c4f5fe4)

- Access the Alertmanager interface at http://localhost:9093 and You should see active alerts and their status.

![302149838-70c9b977-8bea-4bb1-9717-ca24a302f7a9](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/ef635847-19a1-43a3-ac81-cdc8b501ef77)

- Access the Grafana at http://localhost:3000 and You should see spike in the CPU Usage panel.( for PromQL Query `100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)` )
  
![302149748-7acbd01b-5b66-4ef1-9046-64a2de0b2006](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/129f6e6d-fc45-49b5-9b7c-eae2a966b67b)


---

## 7️⃣ Docker Engine Metrics:

We can also scrap the docker engine metrics, which helps us to keep an eye on Container runtime if we have container workloads on the System.

### Step 1: Install Docker:

- Run the below command (I am using Ubuntu VM)
```
sudo apt  install docker.io
```
### Step 2: Enable Docker Metrics:
- Create a daemon.json file in the directory /etc/docker and add the below content.
```
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
```
- Now restart the docker
```
systemctl restart docker
```
### Step 3: Configure Prometheus:

- Edit the prometheus.yml file in the ~/etc/prometheus/ directory. Use a text editor like Nano or Vim:

```
vim /etc/prometheus/prometheus.yml
```
- Add the following configuration to prometheus.yml to add docker as a scraping target for Prometheus:

```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']

rule_files:
  - rules1.yml

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093
```
- We need to restart Prometheus so that the new configuration will be applied.
```
sudo systemctl restart prometheus
```
### Step 4: Verify Docker Metrics:

- Check if the Docker is publishing its metrics on port 9323. Navigate to localhost:9323/metrics
  
![303845529-0ae464a5-1714-459b-b93f-b7d5357a853f](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/0e317312-5fd5-499e-8081-6df6f4114185)

- Check the metrics in the Prometheus UI

![303845488-41b765ae-d5b4-480c-8ea1-bcd5903d905e](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/6addac07-8d60-472a-86da-0eea504fd940)

- Also check Prometheus targets
  
![303845442-d96c6d9a-f72d-4bea-9bd2-198f0fda727d](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/538ea5cf-c139-415e-b2cb-b5c7158cb331)

---

## 8️⃣ Blackbox Exporter Setup:

Login into your VM through SSH and follow these steps to download and install Blackbox Exporter:

### Step 1: Install Blackbox Exporter:

- Execute the following commands:
```
# Create a directory for Blackbox Exporter
mkdir ~/Blackbox

# Change into the Blackbox Exporter directory
cd ~/Blackbox

# Download the latest version of Blackbox Exporter
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.24.0/blackbox_exporter-0.24.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf blackbox_exporter-0.24.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv blackbox_exporter-* blackbox
```
Refer: https://prometheus.io/download/#blackbox_exporter

### Step 2: Configure Blackbox:

You can configure the Blackbox Exporter through the blackbox.yml file.

- Edit the blackbox.yml file in the ~/Blackbox/blackbox directory. Use a text editor like Nano or Vim:

```
vim ~/Blackbox/blackbox/blackbox.yml
```
- Append the following configuration to blackbox.yml: I am adding 2 probs, **dns_google** - checks the DNS server's liveliness & **http_redflagdeals** - checks the word "sale" on any webpage.

```
module:
  ...
  < default configuration >
  ...
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
```
Refer: https://github.com/prometheus/blackbox_exporter/blob/master/CONFIGURATION.md

### Step 3: Running Blackbox Exporter as a Service on the VM

- Create user **balckbox_exporter**
```
sudo useradd blackbox
```
- Copy file from Blackbox Exporter setup
```
cd ~/Blackbox
sudo cp blackbox/blackbox_exporter /usr/local/bin/
sudo mkdir /etc/blackbox
sudo cp blackbox/blackbox.yml /etc/blackbox/
```
- Assign ownership of files to blackbox user
```
sudo chown blackbox:blackbox /usr/local/bin/blackbox_exporter
sudo chown -R blackbox:blackbox /etc/blackbox/*
```
- Add systemd service unit file for Blackbox Exporter.
```
sudo vim /etc/systemd/system/blackbox.service
```
- Add the following and save the file.
```
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
```
- Run the Blackbox Exporter service
```
sudo systemctl daemon-reload
sudo systemctl enable blackbox
sudo systemctl start blackbox
```
### Step 4: Configure Prometheus:

- Edit the prometheus.yml file in the ~/etc/prometheus/ directory. Use a text editor like Nano or Vim:

```
vim /etc/prometheus/prometheus.yml
```
- Add the following configuration to prometheus.yml to add the above configured probes as a scraping target for Prometheus:

```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']
  - job_name: 'blackbox_dns'
    metrics_path: /probe
    params:
      module:
        - dns_google
    static_configs:
      - targets: ['8.8.8.8']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115
  - job_name: 'redflag-sale-status'
    metrics_path: /probe
    params:
      module:
        - http_redflagdeals
    static_configs:
      - targets: ['https://www.redflagdeals.com']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115

rule_files:
  - rules1.yml

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093
```
- We need to restart Prometheus so that the new configuration will be applied.
```
sudo systemctl restart prometheus
```
### Step 5: Verify Blackbox Exporter:

- Check if the Blackbox is running.
```
sudo systemctl status blackbox
```
![303856959-8d72a045-5693-433c-a325-1f9715c867a8](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/67fbdad2-9cfc-425b-bbe1-8898815d2500)

- Open your web browser and navigate to http://localhost:9115. You should see the Blackbox Exporter web interface showing recent probes.
  
![303856763-847de848-6a64-46ea-a680-4afdc06c88d2](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/8412f0f3-c384-4e4a-8ba9-7bb2bd23a2e8)

---

## 9️⃣ Push Gateway Setup:

Login into your VM through SSH and follow these steps to download and install Push Gateway:

### Step 1: Install Push Gateway:

- Execute the following commands:
```
# Create a directory for Pushgateway
mkdir ~/Pushgateway

# Change into the Gateway directory
cd ~/Pushgateway

# Download the latest version of Push Gateway
wget https://github.com/prometheus/pushgateway/releases/download/v1.7.0/pushgateway-1.7.0.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xvf pushgateway-1.7.0.linux-amd64.tar.gz

# Rename the extracted directory for simplicity
mv pushgateway-* pushgateway
```
Refer: https://prometheus.io/download/#pushgateway

### Step 2: Running Push Gateway as a Service on the VM

- Create user **push_gateway**
```
sudo useradd push_gateway
```
- Copy file from Push Gateway setup
```
cd ~/Pushgateway
sudo cp pushgateway/pushgateway /usr/local/bin/
```
- Assign ownership of files to push_gateway user
```
sudo chown push_gateway:push_gateway /usr/local/bin/pushgateway
```
- Add systemd service unit file for Push Gateway.
```
sudo vi /etc/systemd/system/pushgateway.service
```
- Add the following and save the file.
```
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
```
- Run the Push Gateway service
```
sudo systemctl daemon-reload
sudo systemctl enable pushgateway
sudo systemctl start pushgateway
```
### Step 3: Configure Prometheus:

- Edit the prometheus.yml file in the ~/etc/prometheus/ directory. Use a text editor like Nano or Vim:

```
vim /etc/prometheus/prometheus.yml
```
- Add the following configuration to prometheus.yml to add push_gateway as a scraping target for Prometheus:

```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']
  - job_name: 'blackbox_dns'
    metrics_path: /probe
    params:
      module:
        - dns_google
    static_configs:
      - targets: ['8.8.8.8']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115
  - job_name: 'redflag-sale-status'
    metrics_path: /probe
    params:
      module:
        - http_redflagdeals
    static_configs:
      - targets: ['https://www.redflagdeals.com']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115
  - job_name: 'push_gateway'
    honor_labels: true
    static_configs:
      - targets: ['localhost:9091']

rule_files:
  - rules1.yml

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093
```
- We need to restart Prometheus so that the new configuration will be applied.
```
sudo systemctl restart prometheus
```
### Step 4: Verify Push Gateway:

- Check if the Push Gateway is running.
```
sudo systemctl status pushgateway
```
![303860474-d125049f-b241-4ecd-8252-3ecb1fe2bd1b](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/312b530b-0447-4d0d-ad92-0d9abf600a00)

- Open your web browser and navigate to http://localhost:9091. You should see the Push Gateway web interface.
  
![303860927-d10261e0-9ab5-4b74-a5c3-3ad940d8e875](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/93a7cbfc-9e44-4662-875e-f47f24683c26)

### Step 5: Register metrics to Push Gateway:

- Create a Python script using the Prometheus Python Client Library that pushes metrics to Push Gateway.
```
cd ~/Pushgateway
sudo apt install python3-pip
pip install prometheus-client
vim push_register.py
---
from prometheus_client import CollectorRegistry, Gauge, push_to_gateway

registry = CollectorRegistry()

g = Gauge('job_last_success_unixtime', 'Last time a batch job successfully finished', registry=registry)

g.set_to_current_time()

push_to_gateway('localhost:9091', job='batchA', registry=registry)
```
Refer: https://prometheus.github.io/client_python/exporting/pushgateway/

- Create a cron job that runs every 5 minutes. It creates a temporary file using mktemp, then executes the Python script push_register.py using Python 3, and discards any output or error messages generated by the script.
```
crontab -e
2
--
*/5 * * * * /bin/mktemp /tmp/push-XXXXX && /usr/bin/python3 /home/$USER/Pushgateway/push_register.py > /dev/null 2>&1
```
### Step 6: Verify metrics at Push Gateway:

- Open your web browser and navigate to http://localhost:9114. In the Push Gateway web interface, you should see the Metrics that are pushed by the Python script.

![303863385-b371d178-3392-45e7-b120-2acaef9ddf78](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/b7cbc1eb-f7c4-4102-ba4c-a751fd69a461)

- We can also see the metrics available in Prometheus.
  
![303863517-f97b0f51-2c97-4459-a963-dc6cb7ab18bb](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/f8ecdbc2-ac29-4aa4-a54a-be3bd81f6953)

## 🔟 Service Discovery:

- Prometheus has multiple methods to discover services to monitor. You can use static configuration, Kubernetes, discovery via DNS SRV records, files with targets listed in them, and Hashicorp’s Consul.
- Prometheus can also use the APIs of some cloud providers to discover services.

In this project, we will cover File-Based Service Discovery.
- If you need to use a service discovery system that is not currently supported, your use case may be best served by Prometheus' file-based service discovery mechanism, which enables you to list scrape targets in a JSON/YAML file (along with metadata about those targets).
Refer: https://prometheus.io/docs/guides/file-sd/

### Step 1: Configure Prometheus for Service Discovery:

- Edit the prometheus.yml file in the /etc/prometheus/ directory. Use a text editor like Nano or Vim:

```
vim /etc/prometheus/prometheus.yml
```
- Add the following configuration to prometheus.yml to add a target called service_discovery that uses the File-Based Service Discovery:
```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']
  - job_name: 'blackbox_dns'
    metrics_path: /probe
    params:
      module:
        - dns_google
    static_configs:
      - targets: ['8.8.8.8']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115
  - job_name: 'redflag-sale-status'
    metrics_path: /probe
    params:
      module:
        - http_redflagdeals
    static_configs:
      - targets: ['https://www.redflagdeals.com']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115
  - job_name: 'push_gateway'
    honor_labels: true
    static_configs:
      - targets: ['localhost:9091']
  - job_name: 'service_discovery'
    file_sd_configs:
    - files:
      - '/etc/prometheus/targets.json'

rule_files:
  - rules1.yml

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093
```
- We need to restart Prometheus so that the new configuration will be applied.
```
sudo systemctl restart prometheus
```
- Until we add a target in the targets.json file, we won't see the service_discovery target in the Prometheus UI.

![303865469-de7f527a-45a9-4c94-b3fd-31942e6c40bc](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/9b2536fd-89b4-4f24-ac03-58b8a7a881c8)

### Step 2: Adding Targets Dynamically:

- Create a targets.json file in the /etc/prometheus/ directory and add the below content.
```
vim /etc/prometheus/targets.json
--
[
  {
    "labels": {
      "job": "grafana"
    },
    "targets": [
      "localhost:3000"
    ]
  }
]
```
- Prometheus automatically reloads the targets.json file periodically (by default every 5 minutes), so changes take effect without needing a manual restart of any service.
  
![303865731-3a87e280-29ca-49da-999a-d50f4b3f7759](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/673d27ed-4766-4968-bbae-0e2f2c626945)

- Add one more target.
```
vim /etc/prometheus/targets.json
--
[
  {
    "labels": {
      "job": "grafana"
    },
    "targets": [
      "localhost:3000"
    ]
  },
  {
    "labels": {
      "job": "alert_manager"
    },
    "targets": [
      "localhost:9093"
    ]
  }
]
```
- Now you can see 2 Endpoints under the service_discovery target.

![303865885-ca802eb9-380f-420d-ac4e-74d4e11dc69b](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/e8c2d833-e077-4c9a-8e50-946cc2efa7a5)

Note: Mostly Ansible is used to generate the target JSON/YAML files that contain the list of VMs & Services that are scrapping targets for Prometheus. So that Prometheus will take targets from that file dynamically. 

---

## 🙏🏻 Acknowledgement

Thank you for checking out my monitoring and alerting project! I hope you found it informative and helpful in understanding the steps required to set up a monitoring and alerting setup.

I love working with Prometheus and I hope that this project has helped you in your DevOps journey.

Once again, thank you for your time and interest in this project. I wish you all the best in your future endeavours.

If you find this project useful or have any suggestions for improvements, feel free to reach out to karthiksaladi047@gmail.com.

Best regards,

**Karthik Saladi**

![303157017-34d2af93-19cf-4a8e-951f-50502339f612](https://github.com/KarthikSaladi047/Prometheus-Monitoring/assets/105864615/6734a370-2b4c-4767-b3c0-6dc28edb0f27)

version: '2'

services:

  prometheus:
    image: prom/prometheus
    container_name: prometheus
    ports:
      - "127.0.0.1:9090:9090"
    volumes:
      - "/opt/data/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml"
      - "prom_data:/prometheus"
    command:
      - '-config.file=/etc/prometheus/prometheus.yml'
      - '-storage.local.path=/prometheus'
      #- '-alertmanager.url=http://alertmanager:9093'
    restart: always

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - "127.0.0.1:3000:3000"
    volumes:
      - "grafana:/var/lib/grafana"
    environment:
        GF_USERS_ALLOW_SIGN_UP: 'false'
    restart: always

  cadvisor:
    image: google/cadvisor:latest
    container_name: cadvisor
    ports:
      - "127.0.0.1:8090:8080"
    volumes:
      - "/:/rootfs:ro"
      - "/var/run:/var/run:rw"
      - "/sys:/sys:ro"
      - "/var/lib/docker/:/var/lib/docker:ro"
    restart: always

  nodeexporter:
    image: prom/node-exporter
    container_name: exporter
    ports:
      - "127.0.0.1:9100:9100"
    restart: always

volumes:
  prom_data:
  grafana:

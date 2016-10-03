version: '2'

services:
  jd2:
    image: "benst/headless-jd2-docker"
    container_name: jd2
    volumes:
      - "/opt/media/download:/opt/downloads"
      - "/opt/data/jd2:/opt/JDownloader/cfg"
    restart: always

version: '2'

services:

  web:
    image: owncloud
    container_name: owncloud
    ports:
      - "127.0.0.1:<%= $localPort %>:80"
    depends_on:
      - db
    volumes:
      - "owncloud_data:/var/www/html"
      - "/opt/media:/opt/media_ro:ro"
      - "/opt/data/download:/opt/download_ro:ro"
    restart: always
    networks:
      - back

  db:
    image: mysql
    container_name: owncloud_db
    networks:
      - back
    volumes:
      - "owncloud_db:/var/lib/mysql"
    environment:
      MYSQL_ROOT_PASSWORD: "<%= $mySQLPw %>"
    restart: always

volumes:
  owncloud_db:
  owncloud_data:

networks:
  back:

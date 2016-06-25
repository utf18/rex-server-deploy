
server {
   listen       80;
   server_name www.<%= $vhost %> <%= $vhost %>;
   return 301 https://<%= $vhost %>$request_uri;
}

server {
   listen 443 ssl ;
   server_name www.<%= $vhost %> <%= $vhost %>;
   root /var/www/www.<%= $vhost %>;
   index index.html index.htm;

   error_page 404 /error/404.html;

   access_log /var/log/nginx/www_access.log;
   error_log /var/log/nginx/www_error.log info;

   ssl_certificate /etc/letsencrypt/live/<%= $vhost %>/fullchain.pem;
   ssl_certificate_key /etc/letsencrypt/live/<%= $vhost %>/privkey.pem;

  location / {
    proxy_pass http://localhost:<%= $localPort %>;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

}

 }

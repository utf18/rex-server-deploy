<VirtualHost *:80>

    Redirect / https://<%= $owncloud %>/
    ServerName <%= $owncloud %>
    DocumentRoot /var/www/<%= $owncloud %>

</VirtualHost>

<VirtualHost *:443>

    ProxyPreserveHost On
    ProxyRequests Off
    ProxyPass / http://127.0.0.1:<%= $localPort %>/
    ProxyPassReverse / http://127.0.0.1:<%= $localPort %>/
    DocumentRoot /var/www/<%= $owncloud %>
    ServerName <%= $owncloud %>
    SSLEngine on
    SSLCertificateKeyFile /etc/letsencrypt/live/<%= $owncloud %>/privkey.pem
    SSLCertificateFile /etc/letsencrypt/live/<%= $owncloud %>/cert.pem
    SSLCertificateChainFile /etc/letsencrypt/live/<%= $owncloud %>/fullchain.pem
</VirtualHost>

# http://vincent.bernat.im/en/blog/2011-ssl-session-reuse-rfc5077.html
 ssl_session_cache shared:SSL:50m;
 ssl_dhparam /etc/nginx/ssl/dhparam.pem;
 ssl_session_timeout 5m;
 ssl_session_tickets off;
 # ssl_session_tickets off; as long as there is no way to rotate the tickets i will turn this off!
 # see https://tools.ietf.org/html/rfc5077#section-5.6
 # see https://timtaubert.de/blog/2014/11/the-sad-state-of-server-side-tls-session-resumption-implementations/
 ssl_prefer_server_ciphers on;
 ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
 # http://blog.ivanristic.com/2013/08/configuring-apache-nginx-and-openssl-for-forward-secrecy.html
 ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";

#  ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:ECDHE-RSA-RC4-SHA:ECDHE-ECDSA-RC4-SHA:RC4-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!3DES:!MD5:!PSK:!RC4';
 ssl_stapling on;
 ssl_stapling_verify on;
 ssl_trusted_certificate /etc/nginx/ssl/chain.pem;

 # config to enable HSTS(HTTP Strict Transport Security) https://developer.mozilla.org/en-US/docs/Security/HTTP_Strict_Transport_Security
 # to avoid ssl stripping https://en.wikipedia.org/wiki/SSL_stripping#SSL_stripping
 add_header Strict-Transport-Security "max-age=31536000; includeSubdomains;";

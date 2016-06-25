[Unit]
Description=<%= $contName %> Container
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker kill <%= $contName %>
ExecStartPre=-/usr/bin/docker rm <%= $contName %>
ExecStartPre=/usr/bin/docker pull <%= $contName %>
ExecStart=/usr/bin/docker run --rm --name <%= $contName %> <%= $runParams %> <%= $imgName %>

[Install]
WantedBy=multi-user.target

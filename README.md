# **First of all what is this:**

This project exists for the sole purpose of installing and configuring a linux server.

I am lazy and i hate writing cookbooks for applications and we all know we are bad at repetitive things.
So i wanted to make sure i am able to redeploy my configuration at any time without hassle.


In order to get this done i chose an easy and powerfull configuration management tool named: rex (see rexify.org)
It is based on perl and gives me the opportunity to have best of both worlds:

1. easy to write and understand
2. powerfull enough to do all the things i need


My whole Setup makes use of this Software:
- Rex from Rexify.org
- Docker
- Debian
- git
- Apache2
- UFW (uncomplicated Firewall)
- watchtower docker container to keep containers up to date
- Certificates from Let's Encrypt with the certbot client

## **Requirements**

What you have to do in order to Use this:
- get yourself a rootserver from a provider of your choice.
  - you have to check whether the provider supports docker or not!
  - you have to install a Distribution of Linux on your own (currently only Debian based Systems are supported, I use Debian 8 minimal)
  - you have to copy your SSH Public Key to the Server (authorized_keys of the User root)
- install rex in at least version 1.3 on your local machine or the machine where you will trigger the deployment from
- get yourself a domain and set the A-record to the IP of your server

## **Get it Started**

1. clone this repo
2. provide your configs:
    - grab your hostname from your remote machine (just type in `hostname` at the shell)
    - duplicate the example hostname.yml file under cmdb and name it <your_hostname_from_the_remote_machine>.yml
    - change the values inside the hostname.yml file according to your needs ### **change the passwords** ###
    - add your remote server in the servers.ini file (see example entries within)
3. verify your rex installation within the cloned repo by typing `rex -T` you will get a list of tasknames and a list of servers to connect to.
3. optional: verify everything is working as expected by starting rex with the parameter uptime. `rex uptime`
it will connect to the destination server and returns the uptime of your server and if you get your username as a return then your hostname.yml file is correctly named.
4. start rex with the parameter "rollout" `rex rollout` (it will install and configure your server the way you specified it)
5. create lets's encrypt certificates: you have to do it manually since certbot is not working with the installation. grab it from here:
https://github.com/certbot/certbot and follow the orders:
  - stop apache2
  - run ./certbot-auto certonly (and choose standalone version)
  - run apache2 again
6. configure the installed applications of your choice (change standard passwords etc...)

## **Documentation**

for the overall *big picture* see rexify.org and see how it is working under the hood.

**how the whole Setup works:**
  applications such as owncloud are provided as docker containers and expose their ports locally on the host.
  the ufw blocks all incoming traffic execpt 22 for SSH and 80,443 for the Apache Server.
  The Apache acts as a reverse proxy for the docker containers behind and does the SSL termination and hands out the let's encrypt certificates.

nothing too fancy here ;)

If you want to add more services just create another install_your-service-here.task file or copy an install.task file and change the values
You have to secify the key/value pairs in the hostname.yml file if you need to use host specific variables. otherwise add them to your task file.
After that you have to add the name to the Rexfile or call rex with the task Name: `rex install_your-service-here` and you're done :)


## **TODO**
  - more Documentation
  - support sudo in order to support more systems e.g. Ubuntu
  -

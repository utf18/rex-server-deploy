# **First of all what is this:**

This project exists for the sole purpose of installing and configuring a linux server the way i would install them manually.

I am lazy and i hate writing cookbooks for applications and we all know we are bad at repetitive things.
So i wanted to make sure i am able to redeploy my configuration at any time without hassle.


In order to get this done i chose an easy and powerfull configuration management tool named: rex (see rexify.org)
It is based on perl and gives me the opportunity to have the best of both worlds:

1. easy to write and understand
2. powerfull enough to do all the things i need


My whole Setup makes use of this Software:
- Rex from Rexify.org
- Docker
- CentOS 7 or Debian 8 (only these two because SystemD is a hard Requirement)
- git
- nginx
- firewalld/ufw
- watchtower docker container to keep containers up to date (this is deprecated, i am trying to develop a nice solution to identify Container changes and rebuild my containers )
- Certificates from Let's Encrypt with the certbot client (gets yourself a shiny a+ rating :D)

## **Requirements**

What you have to do in order to Use this:
- get yourself a rootserver from a provider of your choice.
  - you have to check whether the provider supports docker or not!
  - you have to install a Distribution of RHEL/CentOS/Debian Linux on your own and make sure perl is installed (`yum/apt-get install perl`).
  - you have to copy your SSH Public Key to the Server (authorized_keys of the User root)
- install rex in the latest version (currently 1.4) on your local machine or the machine where you will trigger the deployment from
- get yourself a domain and set the A-record for your (Sub)Domain to the IP of your server

## **Get it Started**

1. clone this repo
2. provide your configs:
    - grab your hostname from your remote machine (just type in `hostname` at the shell)
    - rename the example hostname.yml file under cmdb to your_hostname_from_the_remote_machine.yml
    - change the values inside the hostname.yml file according to your needs ### **change the passwords** ###
    - add your remote server in the servers.ini file (see example entries within)
3. verify your rex installation within the cloned repo by typing `rex -T` you will get a list of tasknames and a list of servers to connect to.
3. optional: verify everything is working as expected by starting rex with the parameter uptime. `rex uptime`
it will connect to the destination server and returns the uptime of your server and if you get your username as a return then your hostname.yml file is correctly named.
4. start rex with the parameter "rollout" `rex rollout` (it will install and configure your server the way you specified it)
5. reboot your server
6. configure the installed applications of your choice (change standard passwords etc...)

## **Documentation**

for the overall *big picture* see rexify.org and see how it is working under the hood.

**how the whole Setup works:**
  applications such as owncloud are provided as docker containers and expose their ports locally on the host.
  the local firewall blocks all incoming traffic execpt 22 for SSH and 80,443 for the Web Server.
  The Web Server acts as a reverse proxy for the docker containers behind and does the SSL termination and hands out the let's encrypt certificates.

nothing too fancy here ;)

If you want to add more services just create another install_your-service-here.task file or copy an docker_*.task file and change the values
You have to secify the key/value pairs in the hostname.yml file if you need to use host specific variables. otherwise add them to your task file.
After that you have to add the name to the Rexfile or call rex with the task Name: `rex your-service-here` and you're done :)

If you don't want for example the watchtower container to be installed just comment out `"docker_watchtower",` in the Rexfile.

i like to receive feedback and accept pull requests.

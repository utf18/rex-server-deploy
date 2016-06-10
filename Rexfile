use Rex -feature => ['1.3', 'exit_status'];
use Rex::CMDB;
use Rex::Transaction;
use Rex::Hardware;
use Rex::Group::Lookup::INI;
use Data::Dumper;

# read the server.ini file and create the server groups
groups_file "servers.ini";

# Load authentication
set cmdb => {
    type => 'YAML',
    path => [
        'cmdb/{hostname}.yml',
        'cmdb/default.yml',
    ],
    merge_behavior => 'LEFT_PRECEDENT',
};

# read all .task files in the folder Rexfile.d
do "Rexfile.d/$_" for (grep { m/\.task$/ } list_files("Rexfile.d/"));

# task which will install the tasks below on the group "rootserver"
task "rollout",group => "rootserver", sub {

 transaction {

      do_task [

        # update the system before package installation
        "update_system",

        # install the given packages
        "install",

        # configure the system
        "configure",

        # create the files and folder in order to run the application "owncloud" in docker
        "install_docker_owncloud",

        # pull and run watchtower
        "install_docker_watchtower",

        # finish the installation
        "finish_installation",


      ];

  };

};


1;

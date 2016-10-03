use Rex -feature => ['1.3', 'exit_status'];
use Rex::CMDB;
use Rex::Transaction;
use Rex::Hardware;
use Rex::Group::Lookup::INI;
use Data::Dumper;
use Rex::Commands::Gather

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

        # install the owncloud compose file
        "compose_owncloud",

        # install the monitoring compose file
        "compose_monitoring",

        # install the jd2 compose file
        "compose_jd2",

        # finish the installation
        "finish",


      ];

  };

};


1;

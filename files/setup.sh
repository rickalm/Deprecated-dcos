#! /bin/bash

# Define the standard directories
#
dcos_dir=/opt/mesosphere
dcos_roles=/etc/mesosphere/roles
dcos_conf=${dcos_dir}/etc/dcos-docker.env

# For all the roles passed into the container
# set the flags
#
# Also use roles to activate our own /setup and /start files as needed
#
mkdir -p ${dcos_roles} 2>/dev/null

for role in $(echo $ROLES | tr ':' ' '); do
  echo Enabling role ${role}
  touch ${dcos_roles}/${role}

  find /setup /start -name "*.sh_${role}" | while read file; do 
    echo ln -sf $file ${file%_${role}}
    ln -sf $file ${file%_${role}}
  done

done

# assemble the list of scripts to run
#
rm /setup.loader 2>/dev/null

# Load our Setup Functions
#
echo . /setup/service_functions.sh >/setup.loader

find /setup/ -name *_setup.sh | sort | while read line; do
  echo echo Running $line >>/setup.loader
  echo . $line >>/setup.loader
done

# Execute the setup 
#
. /setup.loader
rm /setup.loader

ln -sf /start.sh /entrypoint.sh

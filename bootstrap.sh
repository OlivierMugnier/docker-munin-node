#!/bin/bash

MUNIN_CONFIGURATION_FILE=/etc/munin/munin-node.conf
MUNIN_LOG_FILE=/var/log/munin/munin-node-configure.log

if [ ! -z "$ALLOW" ]; then
    echo $ALLOW >> $MUNIN_CONFIGURATION_FILE
fi

if [ ! -z "$HOSTNAME" ]; then
    sed -i 's/host_name .*$/host_name "$HOSTNAME"/' $MUNIN_CONFIGURATION_FILE
fi

# if /var/lib/muninplugins/ do exist, soft link to /etc/munin/plugins
for i in `ls /var/lib/muninplugins/`; do 
  ln -s /var/lib/muninplugins/$i /etc/munin/plugins/$i
done

/etc/init.d/munin-node start
tailf $MUNIN_LOG_FILE

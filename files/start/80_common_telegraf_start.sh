# telegraf package sets unit file executable, systemd gets upset so fix it
#
chmod -x /usr/lib/telegraf/scripts/telegraf.service

# Absorb the passed telegraf config file
#
bash /setup/make_telegraf_conf.sh

# if we created a config file then launch the service
#
if [ -f /etc/telegraf/telegraf.conf ]; then
  systemctl enable /usr/lib/telegraf/scripts/telegraf.service
  systemctl start telegraf
fi

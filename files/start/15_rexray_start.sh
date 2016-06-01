# Find a random port to assign to RexRay
#
read LOWERPORT UPPERPORT < /proc/sys/net/ipv4/ip_local_port_range
while :; do
  REXRAY_PORT="`shuf -i $LOWERPORT-$UPPERPORT -n 1`"
  ss -lpn | grep -q ":$REXRAY_PORT " || break
done


# Create a Rexray config file
#
mkdir -p /etc/rexray
cat <<EOF >>/etc/rexray/config.yml
rexray:
  host: tcp://127.0.0.1:${REXRAY_PORT}
  modules:
    default-admin:
      host: tcp://127.0.0.1:${REXRAY_PORT}
  osDrivers:
  - linux
  storageDrivers:
  - ec2
  volumeDrivers:
  - docker
aws:
  rexrayTag: ${MESOS_CLUSTER}
EOF


# Inform SystemD to start Rexray as part of DCOS
#
echo WantedBy=dcos.target >>/etc/systemd/system/rexray.service
systemctl enable rexray


# Create /dev/xvd devices till we figure out how to do with hotplug
#
for i in $(seq 0 15); do
  devname=/dev/xvd$(printf "\x$(printf %x $[$i+97])")
  [ ! -f ${devname} ] && mknod -m 660 ${devname} b 202 $[$i*16]
  chown root:disk ${devname}
done



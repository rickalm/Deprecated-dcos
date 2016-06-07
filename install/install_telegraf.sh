# Install Telegraf tools
#

RELEASE=0.13.0

# Fetch tools and make sure they exist
#
curl -o - https://dl.influxdata.com/telegraf/releases/telegraf-${RELEASE}_linux_amd64.tar.gz | tar -C /tmp -xzf - \
  || exit 1

test -x /tmp/telegraf-*/usr/bin/telegraf \
  || exit 1


# Create telegraf user and provide access to docker sock
#
useradd -G docker telegraf \
  || exit 1


# Change to the source directory
#
pushd /tmp/telegraf-* 2>&1 >/dev/null

# Install required files
#
install -D etc/logrotate.d/telegraf /etc/logrotate.d/telegraf \
  || exit 1

install -m 555 -D usr/bin/telegraf /usr/bin/telegraf \
  || exit 1

install -m 644 -D usr/lib/telegraf/scripts/telegraf.service /usr/lib/telegraf/scripts/telegraf.service \
  || exit 1


# Add our environment file to the systemd script for telegraf
#
sed -i -e '/[Install]/i EnvironmentFile=-/opt/mesosphere/etc/dcos-docker.env' /usr/lib/telegraf/scripts/telegraf.service

# Symlink the telegraf log dir to our volume mount
#
ln -s /data/var/log/telegraf /var/log/telegraf \
  || exit 1


# Be kind, rewind
#
popd 2>&1 >/dev/null

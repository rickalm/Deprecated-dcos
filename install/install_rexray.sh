# Install RexRay and all of its dependencies
#
set -x

# Install Filesystem & Networking tools we will need
#
yum -y -v install \
  e2fsprogs \
  net-tools \
  iproute \
  which \
  sudo \
  || exit 1

yum -y clean all \
  || exit 1

# Install JQ tools
#
curl -sSLo /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
  || exit 1

test -f /usr/bin/jq \
  || exit 1

chmod +x /usr/bin/jq \
  || exit 1

# Install Rexray
#
curl -sSL https://dl.bintray.com/emccode/rexray/install | sh - \
  || exit 1

test -x /usr/bin/rexray \
  || exit 1

# Symlink Rexray directory into Data
#
ln -sf /data/var/lib/rexray /var/lib/rexray \
  || exit 1

# Install DVDIcli for mesos
#
curl -sSL https://dl.bintray.com/emccode/dvdcli/install | sh - \
  || exit 1

test -x /usr/bin/dvdcli \
  || exit 1



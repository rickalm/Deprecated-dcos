## Release Notes

### Build 009
- Changed mesos-dns sources to insure does not report Docker Network IP addresses

### Build 008
- Removed Requirement for Centos7 build tags to match DCOS tags
- Added DNS Server to build
- Slave shutdown script causes Slave to gracefully exit cluster
- Move Docker Image to Uptake organization
- added xmlstarlet for on-the-fly editing of XML files (to support hdfs-galaxy changes)

### Build 007
- Reorganized /setup and /start directories
- Switched to using _role style symlinking for optional tasks in setup & start
- Changed build process to using buildtags for naming images
- Automatically finds any directories Symlinked to /data and creates targets on launch

### Build 006
- Added DNS Server to build

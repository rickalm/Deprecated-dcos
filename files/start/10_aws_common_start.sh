# If AWS_ZONE or AWS_REGION arnt defined go figure it out
#
AWS_ZONE=${AWS_ZONE:-$(curl -sS http://169.254.169.254/latest/meta-data/placement/availability-zone)}
AWS_REGION=${AWS_REGION:-$(echo ${AWS_ZONE} | sed -e 's/[a-z]$//')}
AWS_SUBNET_ID=${AWS_SUBNET:-$(curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(ifconfig eth0 | grep ether | awk '{print $2}')/subnet-id)}
AWS_INSTANCE_TYPE=${AWS_INSTANCE_TYPE:-$(curl http://169.254.169.254/latest/meta-data/instance-type)}


# If DCOS_ vars arnt defined, use the discovered AWS_ params
#
DCOS_DATACENTER=${DCOS_DATACENTER:-${AWS_ZONE}}
DCOS_REGION=${DCOS_REGION:-${AWS_REGION}}
DCOS_SUBNET=${DCOS_SUBNET:-${AWS_SUBNET_ID}}
DCOS_MACHINE_TYPE=${DCOS_MACHINE_TYPE:-${AWS_INSTANCE_TYPE}}


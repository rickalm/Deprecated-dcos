target=$(which java)
[ -n "${target}" ] && echo JAVA_HOME=$(dirname $(dirname ${target})) >>${dcos_conf}

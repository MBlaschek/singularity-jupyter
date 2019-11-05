#!/bin/bash
# Singularity App runscript
# Author: MB
# Date: 5.11.2019
#
# Executes either the app or the executable
#
usage(){
    echo "Singularity Container"
	if [[ -f /etc/os-release ]]; then
		echo $(grep PRETTY_NAME= /etc/os-release | sed 's/PRETTY_NAME=//')
	elif [[ -f /etc/centos-release ]]; then
		echo $(cat /etc/centos-release)
	else
		echo $(uname -a)
	fi
	
	if [[ -d /scif/apps ]]; then
		echo "SCIF (Apps): " $(ls /scif/apps)
	fi
	print_json
}

print_json(){
	if [[ -f /.singularity.d/labels.json ]]; then
		python <<EOF
import json 
data=json.loads(open('/.singularity.d/labels.json').read())
n=max(map(len, data.keys()))
format='%'+str(n)+'s : %s'
for i in sorted(data.keys()): 
	print(format % (i,data[i]))
EOF
	fi
}

if [ $# -gt 0 ]; then
	if [[ -d /scif/apps ]]; then
		echo $(ls /scif/apps) | grep $1 > /dev/null
		if [ $? -eq 0 ]; then
			name=$1
			echo "Launching app: $name"
			shift
			exec /scif/apps/${name}/scif/runscript "$@"
		else
			echo "Executing: $@"
			exec "$@"
		fi
	else
		echo "Executing: $@"
		exec "$@"
    fi  
else
    usage
    echo "Bye Bye"
fi

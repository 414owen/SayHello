#!/usr/bin/env bash

IFS=$'\n'
people=$(cat users)
touch /tmp/lastloggedon

while true; do
	ps aux | grep pts | grep sshd | grep -v "grep" | sed "s/ .*//g" > /tmp/loggedon
	newlogins=$(diff /tmp/lastloggedon /tmp/loggedon | grep -E "^>" | sed "s/^> //g")
	for person in ${people}; do
		user="$(echo "${person}" | sed "s/ .*//g")"
		echo "Checking if ${user} is logged on"
		for loggedonuser in ${newlogins}; do
			echo "checking against ${loggedonuser}"
			if [ "${loggedonuser}" = "$user" ]; then
				message="$(echo "${person}" | sed -E 's/.*"(.*)"/\1/g')"
				echo "found ${user}, sending this:\n${message}"
				echo "${message}" | write "${loggedonuser}" 
			fi
		done
	done
	rm /tmp/lastloggedon
	mv /tmp/loggedon /tmp/lastloggedon
	lastloggedon=${loggedon}
	sleep 1
done

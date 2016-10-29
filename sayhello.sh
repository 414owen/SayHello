#!/usr/bin/env bash

IFS=$'\n'
people=$(cat messages)
touch /tmp/lastloggedon

while true; do
	ps aux | grep pts | grep sshd | grep -v "grep" | sed "s/ .*//g" > /tmp/loggedon
	newlogins=$(diff /tmp/lastloggedon /tmp/loggedon | grep -E "^>" | sed "s/^> //g")
	for person in ${people}; do
		user="$(echo "${person}" | sed "s/ .*//g")"
		for loggedonuser in ${newlogins}; do
			if [ "${loggedonuser}" = "$user" ]; then
				message="$(echo "${person}" | sed -E 's/.*"(.*)"/\1/g')"
				echo "Found new user ${user}, sending this:"
				echo "${message}"
				echo "${message}" | write "${loggedonuser}" 
			fi
		done
	done
	rm /tmp/lastloggedon
	mv /tmp/loggedon /tmp/lastloggedon
	lastloggedon=${loggedon}
	sleep 1
done

#!/usr/bin/env bash

IFS=$'\n'
people=$(cat users)

while true; do
	loggedon="$(ps aux | grep pts | grep sshd | grep -v "grep" | sed "s/ .*//g")"
	for person in $people; do
		user="$(echo "$person" | sed "s/ .*//g")"
		#echo $user
		#echo "$message"
		for loggedonuser in $loggedon; do
			if [ "$loggedinuser" = "$user" ]; then
				message="$(echo "$person" | sed -E 's/.*"(.*)"/\1/g')"
				echo "found $user, sending this:\n$message"
				echo "$message" | write "$loggedinuser" 
			fi
		done
	done
	sleep 1
done

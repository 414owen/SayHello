# SayHello

This is a little script that detects new user logins to a unix system, and
sends them a message of your choice.

# Usage

```
./sayhello.sh
```

# Defining Messages

Messages are defined in the file 'messages'
The DSL syntax is as follows:

```
USERNAME "MESSAGE"
```

# How it works

* Scan for logged on users
* Diffs this against previous scan
* For all users in the config:
	* Check whether user just logged on
	* If so, send them the configured message

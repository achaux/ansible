#!/bin/sh

DOCROOT="/some/path"

cd $DOCROOT

REVISION=$(/usr/bin/git rev-parse HEAD)
AUTHOR=$(/usr/bin/git  --no-pager log -1 --pretty=format:"%an")
HOST=$(echo $HOSTNAME)

# Notify New Relic
/usr/bin/curl -s -H "x-api-key:xxx" -d "deployment[application_id]=123" -d "deployment[description]=Master Branch deployed on $HOST" -d "deployment[revision]=$REVISION" -d "deployment[user]=$AUTHOR" https://api.newrelic.com/deployments.xml 2>&1 > /dev/null

# Send message back to client
echo  "DEPLOYED $AUTHOR's REVISION $REVISION on $HOST" ; echo

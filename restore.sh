#!/bin/bash

# Fetch a (gzipped) backup file from S3.
# Restore it.

# Bailout if any command fails
set -e

# Fetch the environment
. /etc/environment

# Check that a backup is specified or list all backups!
if [ -z "$1" ]
then
	s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY ls s3://$BUCKET
else
	# Create a temporary directory to hold the backup files.
	DIR=$(mktemp -d)

	# Get the backups from S3
	s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY get s3://$BUCKET$1 $DIR/S1

	# Restore the DB, extract the DB name from the front of the backup file.
	gunzip < $DIR/S1 | mysql -uroot -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD -hmysql ${1%%-*}

	# Clean up
	rm -rf $DIR
fi

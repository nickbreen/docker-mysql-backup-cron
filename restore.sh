#!/bin/bash

# Fetch a (gzipped) backup file from S3.
# Restore it.

. /etc/container_environment.sh

# Bailout if any command fails
set -e

# Check that a backup is specified or list all backups!
if [ -z "$1" ]
then
	s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY ls $BUCKET
else
	# Create a temporary directory to hold the backup files
	DIR=$(mktemp -d)

	# Get the backups from S3
	s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY get $BUCKET$1 $DIR/$1

	# Restore the DB
	gunzip < $DIR/$1 | mysql -uroot -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD -hmysql

	# Clean up
	rm -rf $DIR
fi

#!/bin/bash

# Generate a (gzipped) dumpfile for each database specified in ${DBS}.
# Upload to S3.

# Bailout if any command fails
set -e

# Create a temporary directory to hold the backup files.
DIR=$(mktemp -d)

# Generate a timestamp to name the backup files with.
TS=$(date +%s)

# Backup all databases, unless a list of databases has been specified
if [ -z "$DBS" ]
then
	# Backup all DB's in bulk
	mysqldump -uroot -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD -hmysql --all-databases | gzip > $DIR/all-databases-$TS.sql.gz
else
	# Backup each DB separately
	for DB in $DBS
	do
		mysqldump -uroot -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD -hmysql -B $DB | gzip > $DIR/$DB-$TS.sql.gz
	done
fi

# Upload the backups to S3 --region=$REGION
s3cmd -q --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY sync $DIR/ s3://$BUCKET

# Clean up
rm -rf $DIR

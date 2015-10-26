# Supported tags and respective `Dockerfile` links

- [`latest` (*Dockerfile*)](https://github.com/nickbreen/docker-mysql-backup-cron/blob/master/Dockerfile)

# This Image

A cronjob runs every 8 hours.  It backups all databases unless ```DBS``` 
is specified as a space separated list of DB's to backup using ```mysqldump```.  
The file are ```gzip```ed and uploaded to S3 via ```s3cmd```.

The DB will be connected to as ```root``` and requires ```$MYSQL_ROOT_PASSWORD``` 
be set from the linked DB container.

You must specify an AWS access key and secret key as well as the S3 bucket and
optionally the prefix to store the backups in.

See docker-compose.yml for an example of configuration.

# This Image

A cron job runs every 8 hours.  Override this by setting cron job spec's in
the ```CRON_D_BACKUP``` environment variable.

It backups all databases, unless ```DBS```
is specified as a space separated list of DB's to backup, using ```mysqldump```.  
The file are ```gzip```ed and uploaded to S3 via ```s3cmd```.

The DB will be connected to as ```root``` and requires ```$MYSQL_ROOT_PASSWORD```
be set from the linked DB container.

You must specify an AWS access key and secret key as well as the S3 bucket and
optionally the prefix to store the backups in.

You *must* specify the bucket (rather prefix) with a trailing slash,
e.g. ```s3://some-bucket/``` or ```s3://some-bucket/some-prefix/```.

See docker-compose.yml for an example of configuration.

# Usage

Use ```docker exec <container> /backup.sh``` to take an immediate backup.

Use ```docker exec <container> /restore.sh``` to list available backups to restore
from. Then ```docker exec /restore.sh <filename of backup>``` to
restore it.

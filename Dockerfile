FROM nickbreen/cron

MAINTAINER Nick Breen <nick@foobar.net.nz>

RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get -q update && \
  apt-get -qy install mysql-client apache2-utils s3cmd && \
  apt-get -q clean

ENV ACCESS_KEY="" SECRET_KEY="" BUCKET="" DBS=""

ENV CRON_D_BACKUP="0 1,9,17    * * * root   /backup.sh"

COPY backup.sh restore.sh /

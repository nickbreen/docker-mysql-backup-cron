FROM nickbreen/cron

MAINTAINER Nick Breen <nick@foobar.net.nz>

FROM nickbreen/cron

RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get -q update && \
  apt-get -qy install mysql-client apache2-utils s3cmd && \
  apt-get -q clean

ENV ACCESS_KEY="" SECRET_KEY="" BUCKET="" DBS=""

ENV CRON_TAB="0 1,9,17    * * *    /backup.sh"

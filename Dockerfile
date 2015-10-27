FROM mysql:5.5

MAINTAINER Nick Breen <nick@foobar.net.nz>

RUN apt-get update -q && apt-get install -qy cron python-pip && apt-get clean -q && pip install s3cmd

COPY backup.cron /etc/cron.d/backup
COPY backup.sh restore.sh entrypoint.sh /

ENV ACCESS_KEY="" SECRET_KEY="" BUCKET="" DBS=""

ENTRYPOINT ["/entrypoint.sh"]

CMD ["cron", "-f", "-L", "0"]

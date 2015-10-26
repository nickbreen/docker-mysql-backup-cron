#!/bin/bash

# Persist the environment to file so that cronjobs can source it.
# Just use the system-wide file as this 'system' does exactly one thing, this.
set | grep '^(ACCESS_KEY|SECRET_KEY|BUCKET|DBS)=' > /etc/environment

exec "${@}"

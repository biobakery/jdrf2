#!/bin/bash

supervisord -c /etc/supervisord.conf
supervisorctl start gunicorn
supervisorctl start nginx
tail -f /var/log/supervisord/*.log /var/log/nginx/*.log


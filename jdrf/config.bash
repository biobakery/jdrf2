# update supervisord config and start nginx
# logs will be written to /var/log/supervisord/*.log /var/log/nginx/*.log
supervisord -c /etc/supervisord.conf
supervisorctl start nginx

# start mysql if not alerady running
/etc/init.d/mysql start

# setup mysql with secure install (possible answers no, password, no, no, yes)
mysql_secure_installation

# setup initial mysql database
MYSQL_COMMANDS="create database jdrf; grant all privileges on jdrf.* to 'jdrf_user'@'127.0.0.1' identified by '${JDRF_PASSWORD}'; flush privileges;"
mysql -u root -p -e "$MYSQL_COMMANDS"

# setup initial django database
python manage.py makemigrations
python manage.py migrate

# create django superuser
python manage.py createsuperuser

# collect static content
python manage.py collectstatic

# print command to start gunicorn
START_COMMAND="gunicorn --bind 127.0.0.1:8000 jdrf.wsgi"
printf "The environment is now configured.\nNext run the command to start gunicorn.\n${START_COMMAND}\n"

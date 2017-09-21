# README #

This repository contains the source and configuration for the JDRF MBIC site.

### Install ###

1. Install [Docker](https://www.docker.com/).
2. Clone or download a copy of this repository.
3. Change directories to the main folder of this repository.
4. Build a Docker image containing all dependencies for the site.

    a. ``$ sudo docker build -t jdrf_mbic ./``

5. Create a container from the image (mapping port 80 to 80) and connect to it from a bash prompt

    a. ``$ sudo docker run -it -p 80:80 --name jdrf_mbic_container jdrf_mbic bash``
    
6. From in the container, first edit the secret keys/passwords to customize your setup and then source the script to add them to your environment. Next edit the settings.py file to add your host name. Then run the configuration script to start services running in the container and to setup the environment. Then run gunicorn to start the site.

    a. ``cd /usr/local/src/jdrf``
    
    b. ``vi jdrf/settings.py`` (edit the file to add your host to the list of allowed_hosts)
 
    c. ``vi source_keys.bash`` (edit the keys with any text editor of your choice)
    
    d. ``source source_keys.bash`` (add the new keys to the environment)
    
    e. ``bash config.bash`` (run the configuration script)

    f. ``gunicorn --bind 127.0.0.1:8000 jdrf.wsgi``
    

To stop the container run ``$ sudo docker stop jdrf_mbic_container``. To start the container replace start with stop in the prior command.

    

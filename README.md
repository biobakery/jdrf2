# JDRF2 MBIC #

This repository contains the source and configuration for the JDRF2 MBIC site.

This site hosts data analysis on post-processed (QCed) data.

### Install ###

1. Install [Docker](https://www.docker.com/).
2. Clone or download a copy of this repository.
3. Change directories to the main folder of this repository.
4. Edit the secret keys/passwords (in ``keys.env`` to customize your setup).
5. Edit the settings file (in ``jdrf/jdrf/settings.py`` to add your host name).
6. Build a Docker image containing all dependencies for the site.

    a. ``$ sudo docker build -t jdrf_mbic ./``

7. Create a container from the image (mapping port 80 to 80), start it, and connect to it

    a. ``$ sudo docker create -it --env-file keys.env -p 80:80 --name jdrf_mbic_container jdrf_mbic bash``

    b. ``$ sudo docker start jdrf_mbic_container``
    
    c. ``$ sudo docker exec -it jdrf_mbic_container bash``
    
8. From in the container, first run the configuration script to start services running in the container and to setup the environment. Then run gunicorn to start the site.

    a. ``cd /usr/local/src/jdrf``
    
    b. ``bash config.bash`` (run the configuration script)

    c. ``nohup gunicorn --bind 127.0.0.1:8000 jdrf.wsgi &``
    

To stop the container run ``$ sudo docker stop jdrf_mbic_container``.


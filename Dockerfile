# Docker container for jdrf1
# Last updated: August 16, 2016
#
# Service(s):  kneaddata

FROM docker.io/ubuntu:16.04
MAINTAINER "Simon Chang" <simonychang.hutlab@gmail.com>

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH
ENV LINUXBREWHOME /usr/local/src/.linuxbrew
ENV PATH $LINUXBREWHOME/bin:$PATH
ENV MANPATH $LINUXBREWHOME/man:$MANPATH
ENV PKG_CONFIG_PATH $LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH $LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH

COPY "build/webservice.tgz" /usr/local/src/

RUN apt-get update -y && apt-get -y upgrade \
    && apt-get install -y build-essential \
    && apt-get install -y \
        curl \
        git \
        irb \
        ruby \
        pigz \
	libfreetype6-dev \
	libpng-dev \
	libjpeg-turbo8-dev \
	mariadb-client \
	mariadb-common \
	libmariadb-client-lgpl-dev \
        python-dev \
	python-setuptools \
        python-virtualenv \
        python-pip \
	ldap-utils \
 	libldap-2.4-2 \
	libldap2-dev \
	libsasl2-dev \
	nginx

RUN pip install --upgrade pip && \
    pip install setuptools && \
    pip install supervisor && \
    ln -sv /usr/include/freetype2/ft2build.h /usr/include/ft2build.h && \
    ln -sv /usr/bin/mariadb_config /usr/bin/mysql_config && \
    mkdir -v -p /usr/local/src/.linuxbrew && \
    git clone https://github.com/Homebrew/linuxbrew.git /usr/local/src/.linuxbrew && \
    brew tap biobakery/biobakery && \
    brew install kneaddata && \
    cat /usr/local/src/webservice.tgz | pigz -d | tar -C /usr/local/src -xvf - && \
    mv /usr/local/src/webservice/startup.sh /usr/bin/startup.sh && \
    chmod 755 /usr/bin/startup.sh && \
    cp -v /usr/local/src/webservice/supervisor.ini /etc/supervisord.conf && \
    mkdir -pv /var/log/supervisord && \
    rm -v /etc/nginx/nginx.conf && \
    virtualenv /usr/local/src/jdrf_env && \
    bash -c 'source /usr/local/src/jdrf_env/bin/activate; pip install --upgrade pip wheel setuptools' && \
    bash -c 'source /usr/local/src/jdrf_env/bin/activate; pip install numpy' && \
    bash -c 'source /usr/local/src/jdrf_env/bin/activate; pip install -r /usr/local/src/webservice/requirements.txt' && \
    bash -c 'source /usr/local/src/jdrf_env/bin/activate; pip install -r /usr/local/src/webservice/requirements2.txt' && \
    bash -c 'source /usr/local/src/jdrf_env/bin/activate; pip install -e /usr/local/src/webservice/ccfa/' && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE :80

ENTRYPOINT ["bash", "/usr/bin/startup.sh"]




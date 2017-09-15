#!/bin/bash

tar c webservice | pigz -c > build/webservice.tgz
sudo docker build ./ > build/log 2>&1

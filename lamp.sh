#!/usr/bin/env bash
# Copyright (C) 2014 - 2018, Teddysun <i@teddysun.com>
# 
# This file is part of the LAMP script.
#
# LAMP is a powerful bash script for the installation of 
# Apache + PHP + MySQL/MariaDB/Percona and so on.
# You can install Apache + PHP + MySQL/MariaDB/Percona in an very easy way.
# Just need to input numbers to choose what you want to install before installation.
# And all things will be done in a few minutes.
#
# System Required:  CentOS 6+ / Debian 7+ / Ubuntu 14+
# Description:  Install LAMP(Linux + Apache + MySQL/MariaDB/Percona + PHP )
# Website:  https://lamp.sh
# Github:   https://github.com/teddysun/lamp

apache='httpd-2.4.34'
apache_modules_install=('modsecurity-2.9.2')
mysql='mariadb-10.3.9'
mysql_location='/usr/local/mysql'
mysql_data_location='/usr/local/mysql/data'
php_modules_install=('imagick-3.4.3','php-gmagick-1.1.7RC3')
phpmyadmin='phpMyAdmin-4.8.3-all-languages'
mariadb_location='/usr/local/mariadb'
mariadb_data_location='/usr/local/mariadb/data'
kodexplorer="do_not_install"
dbroot="websitebar777."
php='php-7.1.21'

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cur_dir=`pwd`

include(){
    local include=${1}
    if [[ -s ${cur_dir}/include/${include}.sh ]];then
        . ${cur_dir}/include/${include}.sh
    else
        echo "Error:${cur_dir}/include/${include}.sh not found, shell can not be executed."
        exit 1
    fi
}

#lamp main process
lamp(){
    include config
    include public
    include apache
    include mysql
    include php
    include php-modules

    rootness
    load_config
    pre_setting
}

#Run it
lamp 2>&1 | tee ${cur_dir}/lamp.log

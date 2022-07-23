#!/bin/bash -eux

sudo cp -f home/isucon/init.sh /home/isucon/webapp/sql/init.sh
sudo cp -f etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
sudo cp -f etc/nginx/nginx.conf /etc/nginx/nginx.conf
sudo cp -f etc/nginx/sites-available/isuports.conf /etc/nginx/sites-available/isuports.conf
sudo nginx -t

docker compose -f ../docker-compose-go.yml up --build --force-recreate

sudo systemctl restart isuports.go
sudo systemctl restart nginx
sudo systemctl restart mysql


# slow query logを有効化する
# QUERY="
#  set global slow_query_log_file = '/var/log/mysql/mysql-slow.log';
#  set global long_query_time = 0;
#  set global slow_query_log = ON;
# "
#
# echo $QUERY | sudo mysql -uroot

# log permission
sudo chmod 777 /var/log/nginx /var/log/nginx/*
sudo chmod 777 /var/log/mysql /var/log/mysql/*

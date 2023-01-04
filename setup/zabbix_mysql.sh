#!/bin/bash

mysql -sfu root <<EOS
-- SECURE INSTALLATION:
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');
    -- delete anonymous users
    DELETE FROM mysql.user WHERE User='';
    -- delete remote root capabilities
    DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
    FLUSH PRIVILEGES;

-- CREATE DATABASE FOR ZABBIX:
    create database zabbix character set utf8mb4 collate utf8mb4_bin;
    create user zabbix@localhost identified by 'password';
    grant all privileges on zabbix.* to zabbix@localhost;
    set global log_bin_trust_function_creators = 1;
EOS

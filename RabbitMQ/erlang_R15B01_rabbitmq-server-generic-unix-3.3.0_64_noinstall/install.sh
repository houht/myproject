#!/bin/sh 


echo "install ... ..."

#install erlang
cp -rf erlang_otp_src_R15B01-64-noinstall.tar.gz  /usr/local/
cd /usr/local/
tar zxvf erlang_otp_src_R15B01-64-noinstall.tar.gz
sh ./erlang/erlang.sh

#install rabbitmq
cd -
cp -rf  rabbitmq-server-generic-unix-3.3.0.tar.gz /usr/local/
cd /usr/local/
tar zxvf rabbitmq-server-generic-unix-3.3.0.tar.gz
cd rabbitmq_server-3.3.0
sh rabbitmq.sh
service rabbitd start

#create rabbitmq user
source /etc/profile
#./sbin/rabbitmqctl add_user  ipass ipass_4R5T3E
#./sbin/rabbitmqctl set_permissions -p "/" ipass ".*" ".*" ".*"

#
service iptables stop
chkconfig iptables off

echo "finish"


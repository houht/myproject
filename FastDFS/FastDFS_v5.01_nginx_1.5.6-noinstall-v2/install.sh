#!/bin/sh 


echo -e "install ... ...\n"

read  -p   "Enter Fdfs type: [ tracker: 0 ; storaged: 1 ; All In One: 2;] " type


#install tracker
if [ "$type" = 0 ]; then 
    
    echo "To start the install tracker ... ..."
    
    #install fdfs
    cp -rf FastDFS_v5.01-noinstall.tar.gz  /
    cd /
    tar zxvf  FastDFS_v5.01-noinstall.tar.gz
    read  -p   "Enter This system IP:" ip
    sed -i "s#192.168.1.100#$ip#g"  /etc/fdfs/client.conf
    sh fdfs_tracker.sh
    service fdfsd start
    
    
    #install nginx
    cd -
    cp -rf nginx-noinstall_64-1.5.6.tar.gz /usr/local/
    cd /usr/local/
    tar zxvf nginx-noinstall_64-1.5.6.tar.gz
    cd nginx
    sh nginx_tracker.sh
    service nginxd start
    
    
#install storaged
elif [ "$type" = 1 ]; then 
    
    echo "To start the install storaged ... ..."
    
    
    #install fdfs
    cp -rf FastDFS_v5.01-noinstall.tar.gz  /
    cd /
    tar zxvf  FastDFS_v5.01-noinstall.tar.gz
    read  -p   "Enter Tracker IP:" ip
    sed -i "s#192.168.1.100#$ip#g"  /etc/fdfs/storage.conf
    sh fdfs_storage.sh
    service fdfsd start
    
    
    #install nginx
    cd -
    cp -rf nginx-noinstall_64-1.5.6.tar.gz /usr/local/
    cd /usr/local/
    tar zxvf nginx-noinstall_64-1.5.6.tar.gz
    cd nginx
    sh nginx.sh
    service nginxd start
    

#install all in one
elif [ "$type" = 2 ]; then 
    
    echo "To start the install All In One ... ..."

    
    #install fdfs
    cp -rf FastDFS_v5.01-noinstall.tar.gz  /
    cd /
    tar zxvf  FastDFS_v5.01-noinstall.tar.gz
    read  -p   "Enter This system IP:" ip
    sed -i "s#192.168.1.100#$ip#g"  /etc/fdfs/client.conf
    sed -i "s#192.168.1.100#$ip#g"  /etc/fdfs/storage.conf
    sh fdfs.sh
    service fdfsd start
    
    #install nginx
    cd -
    cp -rf nginx-noinstall_64-1.5.6.tar.gz /usr/local/
    cd /usr/local/
    tar zxvf nginx-noinstall_64-1.5.6.tar.gz
    cd nginx
    sh nginx.sh
    service nginxd start

else
    echo 'Input error!'
    exit 0
fi




# Close iptables
service iptables stop
chkconfig iptables off

echo "finish"


#!/bin/bash
NODE_IP=$1
NODE_NAME=$2
BASTION_IP=194.47.155.148

ssh -i ~/.ssh/openstack_key -o StrictHostKeyChecking=no \
    -o ProxyCommand="ssh -i /home/srinika/.ssh/openstack_key -W %h:%p -o StrictHostKeyChecking=no ubuntu@$BASTION_IP" \
    ubuntu@$NODE_IP << ENDSSH
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "127.0.1.1 $NODE_NAME" | sudo tee -a /etc/hosts
sudo apt update -y
sudo apt install -y python3-pip snmpd
sudo pip3 install flask
sudo cp /etc/systemd/system/flask.service /tmp/ 2>/dev/null || true
ENDSSH

#! /usr/bin/env bash
yum install epel-release -y
yum update -y
yum install openvpn easy-rsa -y
cd /etc/openvpn/
mkdir easy-rsa
cd /usr/share/easy-rsa/3.0.6
cp -rf * /etc/openvpn/easy-rsa/
cd /etc/openvpn/easy-rsa/
./easyrsa init-pki
echo 'server' | ./easyrsa build-ca nopass
./easyrsa gen-dh
echo 'server' | ./easyrsa gen-req server nopass
echo 'yes' | ./easyrsa sign-req server server
mkdir /etc/openvpn/keys/
chmod 750 /etc/openvpn/keys
cp -a /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn/keys/
cp -a /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn/keys/dh2048.pem
cp -a /etc/openvpn/easy-rsa/pki/issued/server.crt /etc/openvpn/keys/
cp -a /etc/openvpn/easy-rsa/pki/private/server.key /etc/openvpn/keys/
cd /etc/openvpn/easy-rsa
echo 'client' | ./easyrsa gen-req client nopass
echo 'yes' | ./easyrsa sign-req client client
cp -a /etc/openvpn/easy-rsa/pki/issued/client.crt /etc/openvpn/keys/
cp -a /etc/openvpn/easy-rsa/pki/private/client.key /etc/openvpn/keys/
mv /vagrant/server.conf /etc/openvpn/
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
systemctl -f enable openvpn@server.service
systemctl start openvpn@server.service

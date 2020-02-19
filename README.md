# otus_23
# Мосты, туннели и VPN

# Задание
VPN
1. Между двумя виртуалками поднять vpn в режимах
- tun
- tap

Прочуствовать разницу.

2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку

__________________________________________________________________________________________________________________

1. Между двумя виртуалками поднять vpn в режимах tun/tap

```iperf3 -c 10.11.12.1 -t 40 -i 5```
 - tun 
 
 ![Image_alt](https://github.com/Edo1993/otus_23/blob/master/11.png)
 
 - tap

![Image_alt](https://github.com/Edo1993/otus_23/blob/master/12.png)

В режиме ```tun``` отправлено больше данных.


2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку

https://www.golinuxcloud.com/install-openvpn-server-easy-rsa-3-centos-7/
https://itdraft.ru/2019/04/18/ustanovka-i-nastrojka-openvpn-klienta-i-servera-i-easy-rsa-3-v-centos-7/
https://1cloud.ru/help/linux/kak-ustanovit-i-nastroit-openvpn-na-centos7

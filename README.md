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

ссылки, которые здорово помогли

https://www.golinuxcloud.com/install-openvpn-server-easy-rsa-3-centos-7/

https://itdraft.ru/2019/04/18/ustanovka-i-nastrojka-openvpn-klienta-i-servera-i-easy-rsa-3-v-centos-7/

https://1cloud.ru/help/linux/kak-ustanovit-i-nastroit-openvpn-na-centos7



В [папке](https://github.com/Edo1993/otus_23/tree/master/openvpn) vagrantfile + скрипт, который поднимает сервер с openvpn.
![Img_alt](https://github.com/Edo1993/otus_23/blob/master/openvpn/21.png)
На стороне клиента выполняем команды:

- вытащить с сервера ключи
```
#без папки client не создалось, пришлось предварительно её ручками запилить
vagrant ssh -c 'cat /opt/ca.crt' > /home/client/ca.crt
vagrant ssh -c 'cat /opt/client.crt' > /home/client/client.crt
vagrant ssh -c 'cat /opt/client.key' > /home/client/client.key
vagrant ssh -c 'cat /opt/dh2048.pem' > /home/client/dh2048.pem
```
- установить openvpn
```
apt-get install openvpn easy-rsa -y
```
- перенести в папку с openvpn ключи и конфиг клиента
```
cp c* /etc/openvpn/client/
```
- Запустить сервис
```
systemctl -f enable openvpn@client.service
systemctl start openvpn@client.service
```
![Img_alt](https://github.com/Edo1993/otus_23/blob/master/openvpn/22.png)

После старта сервиса - не добавляется маршшрут, и, соответственно, туннель не создаётся
![Img_alt](https://github.com/Edo1993/otus_23/blob/master/openvpn/23.png)

![Img_alt](https://github.com/Edo1993/otus_23/blob/master/openvpn/24.png)

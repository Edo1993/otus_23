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

а) ```iperf3 -c 10.11.12.1 -t 40 -i 5```
 - tun 
 
 ![Image_alt](https://github.com/Edo1993/otus_23/blob/master/11.png)
 
 - tap

![Image_alt](https://github.com/Edo1993/otus_23/blob/master/12.png)

В режиме ```tun``` отправлено больше данных.

б) ```arping```
- tun 

```
[vagrant@clienttun ~]$ sudo arping -I tap0 10.11.12.1
arping: Device tap0 not available.
[vagrant@clienttun ~]$ sudo arping -I tun0 10.11.12.1
arping: Device tun0 not available.
```

- tap
```
[vagrant@client ~]$ sudo arping -I tap0 10.11.12.1
ARPING 10.11.12.1 from 10.11.12.2 tap0
Unicast reply from 10.11.12.1 [7A:3E:D6:48:31:6A]  1.533ms
Unicast reply from 10.11.12.1 [7A:3E:D6:48:31:6A]  1.960ms
Unicast reply from 10.11.12.1 [7A:3E:D6:48:31:6A]  1.956ms
Unicast reply from 10.11.12.1 [7A:3E:D6:48:31:6A]  1.936ms
Unicast reply from 10.11.12.1 [7A:3E:D6:48:31:6A]  1.927ms
Sent 5 probes (1 broadcast(s))
Received 5 response(s)
[vagrant@client ~]$ arping -I tun0 10.11.12.1
arping: Device tun0 not available.
```

Разница tun и tap режимов:

*TAP*:

Преимущества:
 - ведёт себя как настоящий сетевой адаптер (за исключением того, что он виртуальный);
 - может осуществлять транспорт любого сетевого протокола (IPv4, IPv6, IPX и прочих);
 - работает на 2 уровне, поэтому может передавать Ethernet-кадры внутри тоннеля;
 - позволяет использовать мосты.
 
Недостатки:
 - в тоннель попадает broadcast-трафик, что иногда не требуется;
 - добавляет свои заголовки поверх заголовков Ethernet на все пакеты, которые следуют через тоннель;
 - в целом, менее масштабируем из-за предыдущих двух пунктов;
 - не поддерживается устройствами Android и iOS (по информации с сайта OpenVPN).

*TUN*:

Преимущества:
 - передает только пакеты протокола IP (3й уровень);
 - сравнительно (отн. TAP) меньшие накладные расходы и, фактически, ходит только тот IP-трафик, который предназначен конкретному клиенту.
 
Недостатки:
 - broadcast-трафик обычно не передаётся;
 - нельзя использовать мосты.

2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку

ссылки, которые здорово помогли

https://www.golinuxcloud.com/install-openvpn-server-easy-rsa-3-centos-7/

https://itdraft.ru/2019/04/18/ustanovka-i-nastrojka-openvpn-klienta-i-servera-i-easy-rsa-3-v-centos-7/

https://1cloud.ru/help/linux/kak-ustanovit-i-nastroit-openvpn-na-centos7



В [папке](https://github.com/Edo1993/otus_23/tree/master/openvpn) vagrantfile + скрипт, который поднимает сервер с openvpn.

 ![Image_alt](https://github.com/Edo1993/otus_23/blob/master/21.png)

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
 ![Image_alt](https://github.com/Edo1993/otus_23/blob/master/15.png)

После старта сервиса проверяем доступ.

(на этом моменте я заплакала)
 ![Image_alt](https://github.com/Edo1993/otus_23/blob/master/14.png)

# Tarantool samples
Настоящий документ не претендует на академичность, полноту и прочие медали. Делаю AS IS, для себя, но может пригодится 
кому-то еще.

## Как запустить tarantool
### Виртуальная машина
Проще всего воспользоваться Vagrant (https://www.vagrantup.com/downloads.html)

Создайте файл с именем ```Vagrant```
```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
end
```

Если у вас Parallels, то ее можно запустить командой из каталога с файлом `Vagrant` 
```bash
vagrant up --provider=parallels
```

Если же у вас VirtualBox, то:  
```bash
vagrant up --provider=virtualbox
```

Подключиться к VM:
```bash
vagrant ssh
```

### Устанавливаем бинарный модуль
Руководство тут: 
https://tarantool.io/en/download/os-installation/1.10/ubuntu/

Дублирую:

```bash
# Заходим рутом, иначе все команды ниже делать через sudo
vagrant@ubuntu-18:~$ sudo -i
```

```bash
apt-get update
apt-get -y install sudo
apt-get -y install gnupg2

apt-get -y install curl

curl http://download.tarantool.org/tarantool/1.10/gpgkey | sudo apt-key add -

apt-get -y install lsb-release
release=`lsb_release -c -s`

apt-get -y install apt-transport-https

rm -f /etc/apt/sources.list.d/*tarantool*.list
echo "deb http://download.tarantool.org/tarantool/1.10/ubuntu/ ${release} main" | tee /etc/apt/sources.list.d/tarantool_1_10.list
echo "deb-src http://download.tarantool.org/tarantool/1.10/ubuntu/ ${release} main" | tee -a /etc/apt/sources.list.d/tarantool_1_10.list

sudo apt-get -y update
sudo apt-get -y install tarantool
```

Всё, tarantool установлен.

## Примеры
Нужно склонировать этот репозиторий 

```bash
git clone https://github.com/zaraysky/tnt_samples.git
cd tnt_samples/
```

И проверить, что tarantool работает:
```bash
tarantool init.lua
```

### 

[Простое нагрузочное тестирование](perftest.md) 





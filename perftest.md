# Нагрузочное тестирование

## Подготовка

### Установка nginx



https://github.com/tarantool/nginx_upstream_module

git clone https://github.com/tarantool/nginx_upstream_module.git nginx_upstream_module
cd nginx_upstream_module
git submodule update --init --recursive
git clone https://github.com/nginx/nginx.git nginx

# Ubuntu
apt-get install libpcre++0 gcc unzip libpcre3-dev zlib1g-dev libssl-dev libxslt-dev

make build-all


apt-get install libpcre3 libpcre3-dev

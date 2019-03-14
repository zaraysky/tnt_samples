#!/usr/bin/env bash

sudo -i

apt update && \
apt -y install sudo && \
apt -y install gnupg2 && \
apt -y install curl && \
curl http://download.tarantool.org/tarantool/1.10/gpgkey | sudo apt-key add - && \
apt -y install lsb-release && \
release=`lsb_release -c -s`

apt -y install apt-transport-https && \
rm -f /etc/apt/sources.list.d/*tarantool*.list && \
echo "deb http://download.tarantool.org/tarantool/1.10/ubuntu/ ${release} main" | tee /etc/apt/sources.list.d/tarantool_1_10.list && \
echo "deb-src http://download.tarantool.org/tarantool/1.10/ubuntu/ ${release} main" | tee -a /etc/apt/sources.list.d/tarantool_1_10.list && \
apt -y update && \
apt -y install tarantool


apt -y install curl gnupg2 ca-certificates lsb-release && \
echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list && \
echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list && \
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add - && \
apt-key fingerprint ABF5BD827BD9BF62 && \
apt update && \
apt -y install nginx

cd

# find latest here: https://nginx.org/download/
wget https://nginx.org/download/nginx-1.15.9.tar.gz && tar zxvf nginx-1.15.9.tar.gz

# PCRE version 8.43
wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz && tar xzvf pcre-8.43.tar.gz

# zlib version 1.2.11
wget https://www.zlib.net/zlib-1.2.11.tar.gz && tar xzvf zlib-1.2.11.tar.gz

# OpenSSL version 1.1.1b
wget https://www.openssl.org/source/openssl-1.1.1b.tar.gz && tar xzvf openssl-1.1.1b.tar.gz

# Clean up all .tar.gz files. We don't need them anymore
rm -rf *.tar.

# Build from source (Development version)

git clone https://github.com/tarantool/nginx_upstream_module.git nginx_upstream_module && \
cd nginx_upstream_module && \
git submodule update --init --recursive && \
git clone https://github.com/nginx/nginx.git nginx

# Ubuntu
apt -y install libpcre++0v5 gcc unzip libpcre3-dev zlib1g-dev libssl-dev libxslt-dev

make build-all

cd

git clone https://github.com/openresty/lua-nginx-module.git && \
git clone https://github.com/openresty/luajit2.git && \
cd luajit2/ && \
make && \
make install

cd
export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.1

apt -y install libgd-dev
apt -y install  libgeoip-dev

cd ~/nginx-1.15.9 && \
./configure --with-cc-opt='-g -O2 -fdebug-prefix-map=/build/nginx-FIJPpj/nginx-1.14.0=. -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_sub_module --with-http_xslt_module=dynamic --with-stream=dynamic --with-stream_ssl_module --with-mail=dynamic --with-mail_ssl_module --add-module=/root/nginx_upstream_module --add-module=/root/lua-nginx-module/ && \
make && \
make install

/usr/share/nginx/sbin/nginx -V
/usr/share/nginx/sbin/nginx -v

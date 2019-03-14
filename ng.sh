#!/usr/bin/env bash



sudo apt install curl gnupg2 ca-certificates lsb-release

echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list

echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list

curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -

sudo apt-key fingerprint ABF5BD827BD9BF62

sudo apt update
sudo apt install nginx


cd


# find latest here: https://nginx.org/download/
wget https://nginx.org/download/nginx-1.15.9.tar.gz && tar zxvf nginx-1.15.9.tar.gz


# PCRE version 8.43
wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz && tar xzvf pcre-8.43.tar.gz


# zlib version 1.2.11
wget https://www.zlib.net/zlib-1.2.11.tar.gz && tar xzvf zlib-1.2.11.tar.gz


# OpenSSL version 1.1.1b
wget https://www.openssl.org/source/openssl-1.1.1b.tar.gz && tar xzvf openssl-1.1.1b.tar.gz


#Install optional NGINX dependencies:
sudo add-apt-repository -y ppa:maxmind/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install -y perl libperl-dev libgd3 libgd-dev libgeoip1 libgeoip-dev geoip-bin libxml2 libxml2-dev libxslt1.1 libxslt1-dev


# Clean up all .tar.gz files. We don't need them anymore
rm -rf *.tar.


# Dep-s
#https://github.com/lloyd/yajl.git



# Build from source (Development version)

git clone https://github.com/tarantool/nginx_upstream_module.git nginx_upstream_module
cd nginx_upstream_module
git submodule update --init --recursive
git clone https://github.com/nginx/nginx.git nginx

# Ubuntu
#apt-get install libpcre++0 gcc unzip libpcre3-dev zlib1g-dev libssl-dev libxslt-dev
apt-get install libpcre++0v5 gcc unzip libpcre3-dev zlib1g-dev libssl-dev libxslt-dev


make build-all


git clone https://github.com/openresty/lua-nginx-module.git

git clone https://github.com/openresty/luajit2.git
cd luajit2/
make
make install

export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.1


apt-get install libgd-dev

apt install  libgeoip-dev

cd ~/nginx-1.15.9
./configure --with-cc-opt='-g -O2 -fdebug-prefix-map=/build/nginx-FIJPpj/nginx-1.14.0=. -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_sub_module --with-http_xslt_module=dynamic --with-stream=dynamic --with-stream_ssl_module --with-mail=dynamic --with-mail_ssl_module --add-module=/root/nginx_upstream_module --add-module=/root/lua-nginx-module/

make
make install


/usr/share/nginx/sbin/nginx -V
# edit nginx.conf
/usr/share/nginx/sbin/nginx -c $(env pwd)/nginx.conf

tarantollctl rocks install http



# install wrk
cd
git clone https://github.com/wg/wrk.git wrk
cd wrk
make
# move the executable to somewhere in your PATH, ex:
sudo cp wrk /usr/local/bin

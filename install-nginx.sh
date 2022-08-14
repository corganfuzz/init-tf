#! /bin/bash

function set_up_apt_repos() {
    echo \
        "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" \
        > /etc/apt/sources.list.d/nginx.list
    echo \
        "deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" \
        >> /etc/apt/sources.list.d/nginx.list
}

function import_signing_keys() {
    wget http://nginx.org/keys/nginx_signing.key
    apt-key add nginx_signing.key
}

function install_nginx() {
    apt-get update
    apt-get -y install nginx
}

function start_nginx() {
    nginx -v                    # to make sure Nginx OSS is there first
    /etc/init.d/nginx start
}

main () {
    set_up_apt_repos
    import_signing_keys
    install_nginx
    start_nginx
}

main "$@"

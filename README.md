# oh-my-nginx

**Config Nginx in 2018 like Caddy server!**

This project aims to be a modular Nginx config template to ease common tasks like proxying websites, offloading SSL, redirecting URLs, etc.

## Compatibility

We assume you are using the mainline version of Nginx. Some new exciting features (http2, stream, etc.) are not supported on old versions (stable and/or distro packages).

[Here](https://nginx.org/en/linux_packages.html) is instruction for installing latest version of nginx. 

## Installation

If you already have production sites running on Nginx, don't do anything stupid. You should only take essential pieces from here and evaluate your own config on staging environment.

If you are starting with a clean Nginx installation with any custom config, you can directly replace your nginx config sketelon with this one:

```shell
# run as root
rm -r /etc/nginx
git clone https://github.com/Jamesits/oh-my-nginx.git /etc/nginx
```

## Usage

### Directory Structure

 * `conf.d/*.conf` is where your HTTP/HTTPS config lives
 * `stream.conf.d/*.conf` is for TCP proxy

There are various `.example` files in these two directory; you can use them as a start point and modify it to suit your needs. Basically you need to change these values:

 * `server_name` to your domain (set up DNS to point to your server IP!)
 * `proxy_pass` to your backend or what you want to proxy from
 * `ssl_certificate` and `ssl_certificate_key` to your SSL key file (If you use [certbot](https://certbot.eff.org/) then you may only need to edit `example.com` part)

## Semi-automatic Let's Encrypt signing

We implemented a semi-automatic LE signing method with no service disruption during signing process. To use this you need [autocert](https://github.com/Jamesits/autocert).

It works now but the documentation is on its way. Check back later.

## Notes

This config template is derived from [James Swineson](https://swineson.me)'s production server. They are based on the official config template of Nginx 1.12.
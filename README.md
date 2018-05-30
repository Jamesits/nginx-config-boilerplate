# oh-my-nginx

**Modular Nginx config for modern, secure sites in 2018.**

> 凭谁问：廉颇老矣，尚能饭否？——辛弃疾

This project aims to be a modular Nginx config template to ease common tasks like proxying websites, redirecting URLs, (semi-automatically) signing Let's Encrypt, offloading SSL, etc.

## Compatibility

We assume you are using the mainline version of Nginx with at least the official sets of modules. Some new exciting features (http2, stream, etc.) are not supported on old versions (stable and/or distro packages). 

[Here](https://nginx.org/en/linux_packages.html) is instruction for installing latest version of nginx. 

Compatibility with other Nginx-derived projects (OpenResty, etc.) and 3rd party modules are not verifyed. If you have interest in verifying with/supporting them, contributions are welcomed.

## Installation

If you already have production sites running on Nginx, don't do anything stupid. You should only take essential pieces from here and evaluate your own config on staging environment.

If you are starting with a clean Nginx installation without any custom config, you can directly replace your nginx config sketelon with this one:

```shell
# run as root
rm -r /etc/nginx
git clone https://github.com/Jamesits/oh-my-nginx.git /etc/nginx
openssl dhparam -out /etc/ssl/dhparam.pem 4096
```

## Usage

### Directory Structure

 * `conf.d/*.conf` is where your HTTP/HTTPS config lives
 * `stream.conf.d/*.conf` is for TCP proxy

There are various `examples/*.conf` files in these two directory; you can use them as a start point (copy it to `conf.d/` or `stream.conf.d/` and rename them) and modify it to suit your needs. Basically you need to change these values:

 * `server_name` to your domain (set up DNS to point to your server IP!)
 * `proxy_pass` to your backend or what you want to proxy from
 * `ssl_certificate` and `ssl_certificate_key` to your SSL key file (If you use [certbot](https://certbot.eff.org/) then you may only need to edit `example.com` part)

## Semi-automatic Let's Encrypt signing

We implemented a semi-automatic LE signing method with no service disruption during signing process. To use this you need [autocert](https://github.com/Jamesits/autocert).

Detailed documentation is on its way. Check back later.

## Notes

This config template is originated from [James Swineson](https://swineson.me)'s production server (One of my load balancers running Ubuntu 16.04). They are based on the official config template of Nginx 1.12.

Some fossil versions of Nginx uses a different directory structure:

 * `/etc/nginx/sites-available/*.conf` to store all sites configuration;
 * `/etc/nginx/sites-enabled/*.conf` are symlinks from `sites-available` and they are actually included in the main config.

We do not use this structure anymore, and `conf.d/` works exactly the same like `sites-enabled/` (though without the symlinks). If you want to temporary disable a config just append a `.disabled` on its name (other suffixes are fine as long as the last part of the file name is not `.conf`).

#!/bin/bash
set -Eeuxo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"/..

# generate a default cert -- assuming new openssl versions
# new ECC curves are deliberately chosen to minimize compatibility
# so the first vhost will not be exposed under https://server_ip
openssl ecparam -name brainpoolP512t1 -genkey -param_enc explicit -out conf.d/default.key
openssl req -new -x509 -subj "/CN=DO_NOT_TRUST.example.com\/emailAddress=noreply@example.com/C=AA/ST=Nonexistent/L=Nonexistent/O=Nonexistent/OU=Nonexistent" -days 114514 -key conf.d/default.key -out conf.d/default.crt

# generate a default dhparam
openssl dhparam -out /etc/ssl/dhparam.pem 4096

# test config
nginx -t

set +x
echo "Kickstart finished, now reload your nginx config!"

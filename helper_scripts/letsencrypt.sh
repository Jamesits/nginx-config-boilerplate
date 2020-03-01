#!/bin/bash
set -Eeuxo pipefail

SERVERNAME=${1}

certbot certonly --standalone -n --agree-tos --preferred-challenges http --http-01-port 2378 -d ${SERVERNAME}

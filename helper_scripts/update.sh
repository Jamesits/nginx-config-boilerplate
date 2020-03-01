#!/bin/bash
set -Eeuxo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"
git pull

#!/bin/bash
set -e

which openssl > /dev/null 2>&1 || { echo "openssl is not installed"; exit 1; }

if [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters" >&2
    exit 2
fi

path="$2"

case "$1" in
    flutter)
        openssl x509 -noout -fingerprint -sha256 -inform pem -in ../assets/certificate/$path
        ;;
    nginx)
        openssl x509 -noout -fingerprint -sha256 -inform pem -in ../api/nginx/$path
        ;;
    *)
        echo "Invalid option" >&2
        exit 3
        ;;
    esac
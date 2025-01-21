# Nginx

## Test Nginx TLS 1.1/1.0 support
``` bash
# -I Show document header info only
# -v Verbose outputs
# --tlsv1, --tlsv1.0, --tlsv1.1, --tlsv1.2, --tlsv1.3 TLS version
# --tls-max [VERSION] Set maximum allowed TLS version
curl -I -v --tlsv1 --tls-max 1.0 https://localhost:5050
curl -I -v --tlsv1.1 --tls-max 1.1 https://localhost:5050
```

## Test Nginx TLS 1.2 support
``` bash
curl -I -v --tlsv1.2 --tls-max 1.2 https://localhost:5050
```

## Test Nginx TLS 1.3 support
``` bash
curl -I -v --tlsv1.3 --tls-max 1.3 https://localhost:5050
```
FROM nginx:stable-alpine3.19

COPY ./certs/ca.crt /etc/nginx/certs/ca.pem
COPY ./certs/server.crt /etc/nginx/certs/cert.pem
COPY ./certs/server.pem /etc/nginx/certs/key.pem
COPY ./config /etc/nginx

EXPOSE 5050

CMD ["nginx", "-g", "daemon off;"]
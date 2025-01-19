FROM nginx:stable-alpine3.19

COPY ./certs/server.crt /etc/nginx/certs/nginx.crt
COPY ./certs/server.pem /etc/nginx/certs/nginx.key
COPY ./config /etc/nginx

EXPOSE 5051

CMD ["nginx", "-g", "daemon off;"]
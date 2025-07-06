FROM nginx:stable-alpine3.19

COPY ./certs/ca.crt /etc/nginx/certs/ca.crt
COPY ./certs/server.crt /etc/nginx/certs/server.crt
COPY ./certs/server.pem /etc/nginx/certs/server.pem
COPY ./config /etc/nginx

EXPOSE 5051

CMD ["nginx", "-g", "daemon off;"]
FROM nginx:stable-alpine3.19

COPY ./html /var/www
COPY ./config /etc/nginx

EXPOSE 80 5000

CMD ["nginx", "-g", "daemon off;"]
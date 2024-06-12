FROM nginx:stable-alpine3.19

COPY ./html /var/www
COPY ./config /etc/nginx

EXPOSE 8088 5055

CMD ["nginx", "-g", "daemon off;"]
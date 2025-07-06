# Install Operating system and dependencies
FROM ubuntu:20.04 as build

# Arguments defined in docker-compose.yml
ARG user
ARG uid

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y curl git unzip
RUN apt-get clean

#ENV DEBIAN_FRONTEND=dialog
#ENV PUB_HOSTED_URL=https://pub.dev/
#ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

RUN groupadd -r flutter-user -g 433 && \
    useradd -u $uid -r -g flutter-user -s /sbin/nologin -c "Docker image user" -d /home/$user $user

USER $user

WORKDIR /flutter
RUN mkdir sdk

# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /flutter/sdk

# Set flutter environment path
ENV PATH="/flutter/sdk/bin:/flutter/sdk/bin/cache/dart-sdk/bin:${PATH}"

WORKDIR /home/$user
# Run flutter doctor
RUN flutter doctor

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# RUN mkdir app
WORKDIR /flutter/app
COPY --chown=$user:flutter-useri . .
# RUN chmod 744 -R /flutter/app
RUN flutter build web --release

# =================================================
FROM nginx:stable-alpine3.19 as runtime

WORKDIR /usr/share/nginx/html
COPY --from=build /flutter/app/build/web .

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 5000

# To run in foreground
CMD ["nginx", "-g", "daemon off;"]

# To run in background
# CMD ["nginx"]
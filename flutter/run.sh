#!/bin/bash
set -e

if [ "$1" = "start" ]; then
    which docker-compose > /dev/null 2>&1 || { echo "docker-compose is not installed"; exit 1; }
		cd ./api
		docker-compose up -d --build
elif [ "$1" = "stop" ]; then
    which docker-compose > /dev/null 2>&1 || { echo "docker-compose is not installed"; exit 1; }
		cd ./api
		docker-compose stop
elif [ "$1" = "delete" ]; then
    which docker-compose > /dev/null 2>&1 || { echo "docker-compose is not installed"; exit 1; }
		cd ./api
		docker-compose down
elif [ "$1" = "ios" ]; then
		which open > /dev/null 2>&1 || { echo "open is not installed"; exit 1; }
		open -a Simulator
elif [ "$1" = "flutter" ]; then
		which flutter > /dev/null 2>&1 || { echo "flutter is not installed"; exit 1; }
		flutter run
else
    echo "Invalid option" >&2; exit 1;
fi


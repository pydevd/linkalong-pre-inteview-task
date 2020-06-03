#!/usr/bin/env bash

docker build --tag=ll-app:latest .

docker run --publish 8000:8000 --detach --name=ll-app ll-appdock
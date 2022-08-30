#!/bin/sh

docker build -t scp . && docker run -p 9191:8080 scp
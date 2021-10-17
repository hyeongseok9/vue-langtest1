#!/usr/bin/env bash

docker build -t mysimplewas .

docker run -p 8080:80 mysimplewas 
#!/usr/bin/env bash

service nginx start

export FLASK_APP=app
flask run

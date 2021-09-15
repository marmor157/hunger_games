#!/bin/sh
set -e

mix deps.get
npm install --prefix ./assets

exec "$@"

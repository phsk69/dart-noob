#!/usr/bin/env sh

set -xe

./tests.sh && \
./docs.sh && \
./build.sh
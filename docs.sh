#!/usr/bin/env sh
set -xe
rm -rf doc/api && \
dart doc && \
open doc/api/index.html
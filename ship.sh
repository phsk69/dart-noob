#!/usr/bin/env sh
set -xe
dart format . && \
dart compile exe bin/aoc2015.dart -o aoc2015 --target-os macos && \
dart doc && \
git add --all && \
git commit -am "auto commit" && \
git push

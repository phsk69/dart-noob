#!/usr/bin/env bash
# requries dart and lcov
set -xe
rm -rf coverage/ && \
mkdir coverage/ && \
dart run test --coverage=coverage/ && \
dart run coverage:format_coverage --lcov --in=coverage/ --out=coverage/lcov.info --package=. --report-on=lib && \
genhtml coverage/lcov.info -o coverage/ && \
open coverage/index.html

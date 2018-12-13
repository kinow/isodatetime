#!/bin/bash

# NOTE: the way to handle long-living commands in the documentation is
# travis_wait 40 coverage run -m isodatetime.tests
# but it does not produce any output, which can be frustrating in case of errors.
# So here we are using the approach documented in the issue
# https://github.com/travis-ci/travis-ci/issues/4190.

coverage run -m isodatetime.tests &
TEST_PID="$!"
minutes=0
limit=40
while kill -0 "${TEST_PID}" >'/dev/null' 2>&1; do
  echo -n -e " \b" # never leave evidences!
  if ((minutes == limit)); then
    exit 1
  fi
  minutes=$((minutes + 1))
  sleep 60
done
wait "${TEST_PID}"
coverage report

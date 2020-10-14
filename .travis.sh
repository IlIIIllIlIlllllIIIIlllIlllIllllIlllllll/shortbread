#!/usr/bin/env bash

if [[ "${TRAVIS_PULL_REQUEST}" != "false" && ! -z "${TRAVIS_PULL_REQUEST}" ]]; then
    rake docker:build
else
    rake docker:push
fi

#!/usr/bin/env bash

if [[ "${TRAVIS_PULL_REQUEST}" != "false" && ! -z "${TRAVIS_PULL_REQUEST}" ]]; then
    make docker-build
else
    make docker-push
fi

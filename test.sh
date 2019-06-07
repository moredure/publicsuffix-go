#!/usr/bin/env bash

set -e
echo "" > coverage.txt

for d in $(go list ./... | grep -v vendor); do
    echo $d
    go test -v -race -coverprofile=profile.out -covermode=atomic $d
    if [[ "$NOCONTEXT" == "1" ]] && [[ "$d" =~ "generator" ]]; then
        continue
    fi
    if [ -f profile.out ]; then
        cat profile.out >> coverage.txt
        rm profile.out
    fi
done

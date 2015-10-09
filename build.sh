#!/bin/bash -x
#

if test -n "$TRAVIS"
then
	export GOPATH=$HOME/gopath
fi

set -e

GIT_DEPTH=10
GIT_BRANCH=master
GIT_REPO="github.com/codeskyblue/forego"

GIT_WORKDIR="$GOPATH/src/$GIT_REPO"
STORAGE_DIR="/gorelease/codeskyblue/forego/$GIT_BRANCH"
export STORAGE_DIR

git clone --depth=$GIT_DEPTH --branch=$GIT_BRANCH \
	"https://$GIT_REPO" "$GIT_WORKDIR"

SELF_DIR=$(cd $(dirname $0); pwd)
cd "$GIT_WORKDIR"
go get -t -v ./...
bash -x $SELF_DIR/gorelease.sh
#bash -c "$(curl -fsSL http://bitly.com/gorelease)" gorelease

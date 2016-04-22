#!/bin/bash -x
#

if test -n "$TRAVIS"
then
	export GOPATH=$HOME/gopath
fi

set -e

GIT_DEPTH=10
GIT_BRANCH=${GIT_BRANCH:-"master"}
GITHUB_REPO=${GITHUB_REPO:-"codeskyblue/forego"}
GIT_REPO="github.com/$GITHUB_REPO"

GIT_WORKDIR="$GOPATH/src/$GIT_REPO"
STORAGE_DIR="/gorelease/$GITHUB_REPO/$GIT_BRANCH"
export STORAGE_DIR

set -x

git clone --depth=$GIT_DEPTH --branch=$GIT_BRANCH \
	"https://$GIT_REPO" "$GIT_WORKDIR"

SELF_DIR=$(cd $(dirname $0); pwd)
cd "$GIT_WORKDIR"
if ! test -d Godeps
then
	go get -v
fi
set +x
bash -x $SELF_DIR/gorelease.sh
#bash -c "$(curl -fsSL http://bitly.com/gorelease)" gorelease
#bash $SELF_DIR/gorelease.sh

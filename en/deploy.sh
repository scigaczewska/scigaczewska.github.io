#!/bin/bash

set e

DIR=`pwd`
REV=`git rev-parse HEAD`
echo "Deploying from $DIR from revision $REV"

bundle exec jekyll build
compass compile -e production --force

pushd .
cd /tmp
git clone https://github.com/scigaczewska/scigaczewska.github.io.git
cd /tmp/scigaczewska.github.io
rm * -Rf
cp -a $DIR/_site/* /tmp/scigaczewska.github.io/
git add --all .
git commit -s -m "From upstream taska revision $REV"
git push origin master:master
rm /tmp/scigaczewska.github.io/ -Rf
popd

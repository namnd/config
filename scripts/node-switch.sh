#!/bin/sh

if [[ $OSTYPE == "darwin"* ]]; then
    system=darwin-x64
else
    system=linux-x64
fi

directory=$HOME/.node-versions

prepare() {
    mkdir -p $directory
}

install() {
    prepare
    version=$1
    package=node-v$version-$system.tar.xz
    url=https://nodejs.org/download/release/v$version/$package
    wget $url -P $directory
    tar -xf $directory/$package -C $directory
    switch $1
}

switch() {
    version=$1
    ln -sf $directory/node-v$version-$system/bin/node $HOME/.local/bin/node
    ln -sf $directory/node-v$version-$system/bin/npm $HOME/.local/bin/npm
}

case "$1" in
    install)
        install $2
        ;;
    switch)
        switch $2
        ;;
esac

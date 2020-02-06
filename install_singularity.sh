#!/bin/bash

if false; then
    echo "Installing dependencies"
    sudo apt-get update && sudo apt-get install -y \
        build-essential \
        libssl-dev \
        uuid-dev \
        libgpgme11-dev \
        squashfs-tools \
        libseccomp-dev \
        pkg-config
fi
if false; then
    echo "Installing GO"
    export VERSION=1.13.5 OS=linux ARCH=amd64 && \
        wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
        sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
        rm go$VERSION.$OS-$ARCH.tar.gz

    echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
        echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
        source ~/.bashrc

    go get -u github.com/golang/dep/cmd/dep
fi

echo "Check for old version ????"
if [ -e /usr/local/bin/singularity ]; then
    echo "Removing old version"
    sudo rm -rf \
        /usr/local/libexec/singularity \
        /usr/local/var/singularity \
        /usr/local/etc/singularity \
        /usr/local/bin/singularity \
        /usr/local/bin/run-singularity \
        /usr/local/etc/bash_completion.d/singularity
fi

echo "Installing Singularity"
export VERSION=3.5.2 && # adjust this as necessary \
    mkdir -p $GOPATH/src/github.com/sylabs && \
    cd $GOPATH/src/github.com/sylabs && \
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \
    cd ./singularity && \
    ./mconfig

echo "Making ..."
make -C ./builddir && \
    sudo make -C ./builddir install

echo "Bash integration"
. /usr/local/etc/bash_completion.d/singularity
echo "Complete"


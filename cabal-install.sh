#!/bin/bash -ex

source cabal-env.sh

sudo apt-get update && sudo apt-get -y install python-software-properties software-properties-common && \
sudo add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
sudo apt-get update

sudo add-apt-repository ppa:saiarcot895/myppa -y && \
sudo apt-get update && \
sudo apt-get -y install apt-fast

sudo  apt-fast update
sudo  apt-fast -y install wget sudo vim curl build-essential

# Multiprecision arithmetic library developers tools, zlib  
sudo apt-get install libgmp-dev zlib1g-dev -y  
sudo -K

# get distr  
mkdir -p $HOME/Downloads
cd $HOME/Downloads
wget -c -q "https://www.haskell.org/ghc/dist/$GHC_VERSION/$GHC_DIST_FILENAME"  
tar xfj $GHC_DIST_FILENAME  
cd ghc-$GHC_VERSION  

# install to  
mkdir -p $HOME/Development/bin/ghc-$GHC_VERSION  
# or choose another path

./configure --prefix=$HOME/Development/bin/ghc-$GHC_VERSION  

if `tty -s`; then
    mesg n
fi
make install &> makeinstall.log

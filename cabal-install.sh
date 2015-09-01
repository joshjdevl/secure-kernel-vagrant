#!/bin/bash

set -e
source cabal-env.sh
sudo apt-get update && apt-get -y install python-software-properties software-properties-common && \
sudo add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
sudo apt-get update

sudo add-apt-repository ppa:saiarcot895/myppa && \
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
wget "https://www.haskell.org/ghc/dist/$GHC_VERSION/$GHC_DIST_FILENAME"  
tar xfj $GHC_DIST_FILENAME  
cd ghc-$GHC_VERSION  

# install to  
mkdir $HOME/Development/bin/ghc-$GHC_VERSION  
# or choose another path

./configure --prefix=$HOME/Development/bin/ghc-$GHC_VERSION  

make install

# symbol links  
cd $HOME/Development/bin
rm -f ghc
ln -s `pwd`/ghc-$GHC_VERSION ghc  

# add $HOME/Development/bin/ghc to $PATH  
# add this line to ~/.profile  
export GHC_HOME=$HOME/Development/bin/ghc  
export PATH=$GHC_HOME/bin:${PATH}

# to use updated path without log off
source ~/.profile

# remove temporary files  
cd $HOME/Downloads  
rm -rfv ghc-$GHC_VERSION*

# remove old  
rm -rfv $HOME/.cabal
rm -rfv $HOME/.ghc

# clone dist  
cd $HOME/Downloads  
curl --silent -O "https://www.haskell.org/cabal/release/cabal-$CABAL_VERSION/$CABAL_DIST_FILENAME"  

# extract   
tar xzf $CABAL_DIST_FILENAME  
cd Cabal-$CABAL_VERSION  

# build
ghc --make Setup.hs
./Setup configure --user
./Setup build
./Setup install

# Remove temporary files
cd $HOME/Downloads
rm -rfv Cabal-$CABAL_VERSION*

# get distributive  
cd $HOME/Downloads  
curl --silent -O "https://www.haskell.org/cabal/release/cabal-install-$CABAL_INSTALL_VERSION/$CABAL_INSTALL_DIST_FILENAME"  

# extract archive  
tar xzf $CABAL_INSTALL_DIST_FILENAME  
cd cabal-install-$CABAL_INSTALL_VERSION  

# install  
./bootstrap.sh

# remove temporary files  
cd $HOME/Downloads  
rm -rfv cabal-install-$CABAL_INSTALL_VERSION*  

# add path to cabal to PATH environment
export CABAL_HOME=$HOME/.cabal
export PATH=$CABAL_HOME/bin:$PATH

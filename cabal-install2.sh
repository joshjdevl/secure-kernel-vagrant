#!/bin/bash -ex

source cabal-env.sh

# symbol links  
mkdir -p $HOME/Development/bin
cd $HOME/Development/bin
rm -f ghc
ln -s `pwd`/ghc-$GHC_VERSION ghc  

# add $HOME/Development/bin/ghc to $PATH  
# add this line to ~/.profile  
export GHC_HOME=$HOME/Development/bin/ghc  
export PATH=$GHC_HOME/bin:${PATH}

# to use updated path without log off
#source ~/.profile

if `tty -s`; then
    mesg n
fi

# remove temporary files  
cd $HOME/Downloads  
rm -rfv ghc-$GHC_VERSION*

# remove old  
rm -rfv $HOME/.cabal
rm -rfv $HOME/.ghc

# clone dist  
cd $HOME/Downloads  
curl -O -s "https://www.haskell.org/cabal/release/cabal-$CABAL_VERSION/$CABAL_DIST_FILENAME"  

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
curl -O -s "https://www.haskell.org/cabal/release/cabal-install-$CABAL_INSTALL_VERSION/$CABAL_INSTALL_DIST_FILENAME"  

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

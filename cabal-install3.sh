#!/bin/bash

export GHC_HOME=$HOME/Development/bin/ghc
export PATH=$GHC_HOME/bin:${PATH}

export CABAL_HOME=$HOME/.cabal
export PATH=$CABAL_HOME/bin:$PATH

cabal update
cabal install base

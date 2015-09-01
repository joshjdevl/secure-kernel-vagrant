#!/bin/bash

export CABAL_HOME=$HOME/.cabal
export PATH=$CABAL_HOME/bin:$PATH

cabal update
cabal install base

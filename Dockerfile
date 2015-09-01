FROM ubuntu:14.04
MAINTAINER joshjdevl

ADD cabal-env.sh $HOME/installs/cabal-env.sh
ADD cabal-install.sh $HOME/installs/cabal-install.sh

WORKDIR $HOME/installs
RUN ./cabal-env.sh
RUN ./cabal-install.sh
#RUN ./cabal-install2.sh

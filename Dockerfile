FROM ubuntu:14.04
MAINTAINER joshjdevl

ADD cabal-env.sh $HOME/installs/cabal-env.sh
ADD cabal-install.sh $HOME/installs/cabal-install.sh

WORKDIR $HOME/installs
RUN ./cabal-env.sh
RUN ./cabal-install.sh
ADD cabal-install2.sh $HOME/installs/cabal-install2.sh
RUN ./cabal-install2.sh
ADD cabal-install3.sh $HOME/installs/cabal-install3.sh
RUN ./cabal-install3.sh

ADD sel4.sh $HOME/installs/sel4.sh
RUN ./sel4.sh

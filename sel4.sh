#!/bin/bash -ex

sudo apt-get -qq update && sudo apt-get -qq -y install python-software-properties software-properties-common && \
    sudo add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
    sudo apt-get -qq update

sudo add-apt-repository -y ppa:saiarcot895/myppa && \
    sudo apt-get -qq update && \
    sudo apt-get -qq -y install apt-fast -qq

sudo apt-fast -qq update

sudo apt-fast -qq install -y git phablet-tools

sudo git config --global user.email "<email>"

#http://sel4.systems/Download/
mkdir -p $HOME/bin
curl --silent https://storage.googleapis.com/git-repo-downloads/repo > $HOME/bin/repo

mkdir $HOME/installs
pushd $HOME/installs
wget http://zlib.net/zlib-1.2.8.tar.gz
tar -xvf zlib-1.2.8.tar.gz
cd zlib-1.2.8/
./configure 
make -j 5
sudo make install
popd

chmod a+x $HOME/bin/repo

sudo apt-fast -qq install -y git python

mkdir -p $HOME/seL4test
cd $HOME/seL4test

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

sudo apt-get -qq update
sudo apt-fast -qq install -y build-essential realpath libxml2-utils python-tempita
sudo apt-fast -qq install -y gcc-multilib ccache ncurses-dev

export GHC_HOME=$HOME/Development/bin/ghc
export PATH=$GHC_HOME/bin:${PATH}

export CABAL_HOME=$HOME/.cabal
export PATH=$CABAL_HOME/bin:$PATH

#sudo apt-fast -qq install -y cabal-install ghc libghc-missingh-dev libghc-split-dev 
#sudo cabal install zlib
#sudo cabal install --global cabal-install
cabal update
cabal install zlib data-ordlist
sudo apt-fast -qq install -y python-pip python-jinja2 python-ply
sudo pip install --upgrade pip
sudo pip install pyelftools

#Ubuntu 14.04
sudo apt-get -qq install python-software-properties
sudo add-apt-repository universe
sudo apt-get -qq update
sudo apt-fast -qq install -y gcc-arm-linux-gnueabi
sudo apt-fast -qq install -y qemu-system-arm qemu-system-x86

cd $HOME/seL4test
git config --global color.ui false
$HOME/bin/repo init -u https://github.com/seL4/sel4test-manifest.git
$HOME/bin/repo sync

#Build
make --silent ia32_simulation_release_xml_defconfig
make --silent

#dependencies
sudo apt-fast -qq install -y build-essential lib32z1 lib32ncurses5 lib32bz2-1.0 python python-pip python-tempita realpath libxml2-utils qemu git python-jinja2 python-ply

cd /tmp
sudo mkdir -p /opt/local
wget https://sourcery.mentor.com/public/gnu_toolchain/arm-none-eabi/arm-2013.11-24-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
tar xf arm-2013.11-24-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
sudo mv arm-2013.11 /opt/local/

pip install --user pyelftools

cabal update
cabal install MissingH data-ordlist split
cabal install array mtl

mkdir -p $HOME/camkes-project

cd $HOME/camkes-project

$HOME/bin/repo init -u https://github.com/seL4/camkes-manifest.git
$HOME/bin/repo sync

make --silent arm_simple_defconfig
make --silent silentoldconfig

make ia32_simple_defconfig
make silentoldconfig
make --silent

h#!/bin/bash

set -e

RPATH_FLAGS="-Wl,-rpath,/usr/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial"
MY_LDFLAGS="-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/hdf5/serial ${RPATH_FLAGS}"
MY_CPPFLAGS="-I/usr/local/include -I/usr/include/hdf5/serial"

apt-get update
apt-get -y install build-essential gfortran libblas-dev liblapack-dev libgmp-dev swig libgsl-dev autoconf pkg-config libpng-dev git guile-2.2 guile-2.2-dev libhdf5-dev hdf5-tools libfftw3-dev libpython3-dev python3-numpy python3-h5py python3-pip cmake

mkdir -p ~/install

cd ~/install
git clone https://github.com/NanoComp/harminv.git
cd harminv/
sh autogen.sh --enable-shared
make && make install

cd ~/install
git clone https://github.com/NanoComp/libctl.git
cd libctl/
sh autogen.sh --enable-shared
make && make install

cd ~/install
git clone https://github.com/NanoComp/h5utils.git
cd h5utils/
sh autogen.sh LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make install

cd ~/install
git clone https://github.com/NanoComp/mpb.git
cd mpb/
sh autogen.sh --enable-shared LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && make install

cd ~/install
git clone https://github.com/NanoComp/meep.git
cd meep/
sh autogen.sh --enable-shared PYTHON=python3 LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && make install

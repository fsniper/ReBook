#!/usr/bin/env bash

BOOST_VERSION=boost_1_75_0

# Downloading boost libraries
echo Downloading boost libraries
cd libs
wget https://dl.bintray.com/boostorg/release/1.75.0/source/${BOOST_VERSION}.tar.bz2
tar jxf ${BOOST_VERSION}.tar.bz2

ln -s ${BOOST_VERSION} boost


cd ..


# Downloading rmkit 
echo Downloading rmkit
git clone https://github.com/rmkit-dev/rmkit.git

echo ***********************************************************
echo Make sure you have gcc-arm-linux-gnueabihf and okp installed

sleep 1
mv rmkit libs/

echo Building rmkit.h
cd libs/rmkit
make rmkit.h


#!/usr/bin/env bash

BOOST_VERSION=1.77.0
BOOST_NAME_VERSION=boost_$(echo $BOOST_VERSION | sed 's/\./_/g' -)
BOOST_FILE=$BOOST_NAME_VERSION.tar.bz2
BOOST_URL=https://boostorg.jfrog.io/artifactory/main/release/$BOOST_VERSION/source/$BOOST_FILE

cd libs

if [ ! -f $BOOST_FILE ]; then
    # Downloading boost libraries
    echo Downloading boost libraries
    wget $BOOST_URL
    shasum -c ../$BOOST_FILE.sha256

    if [ ! $? -eq 0 ]; then
        echo "Unable to verify checksum for download from $BOOST_URL"
        echo "Verify the checksum is correct for $BOOST_FILE"
        exit 1
    fi
fi

if [ ! -d ${BOOST_NAME_VERSION} ]; then
    echo "Extracting ${BOOST_FILE}"
    tar jxf ${BOOST_FILE}
fi

if [ ! -h boost ]; then
    ln -s ${BOOST_NAME_VERSION} boost
fi

cd ..

if [ ! -d rmkit ]; then
    # Downloading rmkit 
    echo Downloading rmkit
    git clone https://github.com/rmkit-dev/rmkit.git

fi

if [ ! -d libs/rmkit ]; then
    sleep 1
    mv rmkit libs/
fi

echo "***********************************************************"
echo Make sure you have gcc-arm-linux-gnueabihf and okp installed
echo Building rmkit.h
cd libs/rmkit
make rmkit.h

echo "***********************************************************"
echo "Next steps "
echo "> make"
echo "> scp build/rebook REMARKABLE_IP:/opt/bin" 
echo "> scp build/rebook-go-standardebooks.arm REMARKABLE_IP:/opt"
echo "***********************************************************"

#!/usr/bin/env bash

export BIN=$(pwd)/bin

mkdir -p $BIN/Modules

# Deploy PowerShell modules
(
    cd $BIN/Modules
    cp -r ../../test/Pester .
)

# Build native components
(
    cd src/libpsl-native
    cmake -DCMAKE_BUILD_TYPE=Debug .
    make -j
    ctest -V
    cp src/libpsl-native.* $BIN
)

# Publish PowerShell
(
    cd src/Microsoft.PowerShell.Linux.Host
    dotnet publish --framework dnxcore50 --output $BIN --configuration Linux
    # Copy files that dotnet-publish does not currently deploy
)

#!/bin/bash
set -e
if [ "$TARGET_JDK" == "arm" ]; then
git clone --depth 1 https://github.com/PojavLauncherTeam/openjdk-aarch32-jdk8u openjdk
elif [ "$BUILD_IOS" == "1" ]; then
git clone --depth 1 --branch ios https://github.com/thebaselab/openjdk-multiarch-jdk8u openjdk
else
git clone --depth 1 https://github.com/PojavLauncherTeam/openjdk-multiarch-jdk8u openjdk
fi

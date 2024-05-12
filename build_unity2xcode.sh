#!/bin/bash -xe

echo "Start Unity build"

UNITY_APP_PATH="/Applications/Unity/Hub/Editor/2023.2.20f1/Unity.app/Contents/MacOS/Unity"
UNITY_PROJECT_PATH="./"
UNITY_LOG_PATH="./Builds/build.log"
UNITY_BUILDER_NAME="ApplicationBuilder.Build"
XCODE_PROJECT_PATH="./Builds/iOS"

$UNITY_APP_PATH -batchmode \
    -quit \
    -projectPath $UNITY_PROJECT_PATH \
    -logFile $UNITY_LOG_PATH \
    -executeMethod $UNITY_BUILDER_NAME \
    -output-dir $XCODE_PROJECT_PATH

if [ $? -eq 1 ]; then
    echo "error!! check logfile: ${UNITY_LOG_PATH}"
    exit 1
fi

echo "Finish Unity build"

XCODE_PROJECT_PATH=$XCODE_PROJECT_PATH sh build_xcode2ipa.sh
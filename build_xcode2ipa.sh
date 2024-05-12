#!/bin/bash -xe

echo "Start ipa build"

SCHEME="Unity-iPhone"
PROJECT_PATH="${XCODE_PROJECT_PATH}/${SCHEME}.xcodeproj"
ARCHIVE_FILE="${SCHEME}.xcarchive"
ARCHIVE_DIR="${XCODE_PROJECT_PATH}/archive"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_FILE}"
IPA_DIR="${ARCHIVE_DIR}/output_ipa"
EXPORT_OPTIONS_PLIST="info.plist"

mkdir -p $ARCHIVE_PATH

# ARCHIVE
xcodebuild -project $PROJECT_PATH \
    -scheme $SCHEME \
    archive -archivePath $ARCHIVE_PATH

# ipaファイルの作成
xcodebuild -exportArchive -archivePath $ARCHIVE_PATH \
    -exportPath $IPA_DIR \
    -exportOptionsPlist $EXPORT_OPTIONS_PLIST

echo "Finish ipa build"

IPA_DIR=$IPA_DIR sh install_ipa.sh

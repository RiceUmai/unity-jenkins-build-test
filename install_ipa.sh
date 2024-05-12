#!/bin/bash -xe

echo "Start install"

# Jenkinsのジョブからios-deployを利用するためローカルコマンドへのパスを通す
export PATH=/usr/local/bin:$PATH
source ~/.bashrc

# $IPA_DIRはbuild_xcode2ipa.shから引き継ぐ
cd $IPA_DIR

IPA_FILE=`ls *.ipa`
ID_LIST=($(ios-deploy --detect | grep "iPod touch" | awk '{ print $3 }'))

for i in ${ID_LIST[@]}
do
    ios-deploy --bundle $IPA_FILE --id $i
done

echo "Finish install"

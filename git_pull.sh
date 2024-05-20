#!/bin/bash -xe

echo "Start git pull"

git fetch origin

# GIT_LOCAL_BRANCHが空の場合はGIT_BRANCHから"origin/"以降の文字列を抽出して代入
GIT_LOCAL_BRANCH=${GIT_LOCAL_BRANCH:-${GIT_BRANCH##origin/}}

# ローカルにGIT_LOCAL_BRANCHという名のブランチが存在する場合は単純にHEADを移動。存在しない場合は作成し移動。
# 参考：https://qiita.com/knknkn1162/items/b3af70918770d85bc313
git checkout $GIT_LOCAL_BRANCH

git pull --rebase

echo "Finish git pull"

sh build_unity2xcode.sh

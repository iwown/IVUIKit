#!/bin/bash --login

#Verify variable is provided
if [ "$1" = "" ]; then
        echo -e "Version number not provide"
        exit 1
fi

VERSION=$1

cd /Users/zhanke/Documents/work/IVUIKit
sed -i "" "s/\"\([0-9]\)\.\([0-9]\)\.\([0-9]\)/\"${VERSION}/g" IVUIKit.podspec
git add .
git commit -am "${VERSION}" 
git push
git tag ${VERSION}
git push --tags
pod lib lint --allow-warnings
pod trunk push IVUIKit.podspec

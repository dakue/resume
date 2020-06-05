#!/bin/bash

npm install
export PATH=$PATH:$(pwd)/node_modules/.bin

cd node_modules/jsonresume-theme-orbit
patch -p1 < ../../orbit-highlights.patch
sed -i 's|@sidebar-width: 240px|@sidebar-width: 350px|g' assets/less/default/base.less
npm run build:styles:3
cd ../..

mkdir -p out
resume export -f html -t orbit out/resume.html

#apt-get update
#apt-get install --no-install-recommends -y libgtk-3-0 libasound2 libnss3 libxss1 libxtst6
# puppeteer --no-sandbox --margin-top 0 --margin-right 0 --margin-bottom 0 --margin-left 0 --format A4 print out/resume.html out/resume.pdf

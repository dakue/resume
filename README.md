# resume

## initial setup

```
docker run -it --rm -v $(pwd):/app -w /app node:10 bash

echo "{}" > package.json
npm install resume-cli --save
npm install jsonresume-theme-orbit --save
npm install puppeteer-cli --save
npm install lessc --save
```

## build resume (long)

```
docker run -it --rm -v $(pwd):/app -w /app node:10 bash

npm install
export PATH=$PATH:$(pwd)/node_modules/.bin

cd node_modules/jsonresume-theme-orbit
patch -p1 < ../../orbit-highlights.patch
perl -pi -e 's|@sidebar-width: .*|@sidebar-width: 300px|g' assets/less/default/base.less
npm run build:styles:3
cd ../..

mkdir -p out
resume export -f html -t orbit out/resume.html

#apt-get update
#apt-get install --no-install-recommends -y libgtk-3-0 libasound2 libnss3 libxss1 libxtst6
# puppeteer --no-sandbox --margin-top 0 --margin-right 0 --margin-bottom 0 --margin-left 0 --format A4 print out/resume.html out/resume.pdf
```

## build resume (short)

```
docker run -it --rm -v $(pwd):/app -w /app node:10 bash -c /app/build.sh
```

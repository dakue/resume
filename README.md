# resume

* as [PDF](https://github.com/dakue/resume/raw/master/out/resume.pdf)
* as [HTML](https://dakue.github.io/resume/out/resume.html)

Best printed with the following settings in Chrome:

* media type screen (Developer Tools -> More Tools -> Rendering -> Emulate Media type -> screen
* margin top and bottom 1 cm
* show background grafics
* scale 75%
* format A4

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
perl -pi -e 's|\@sidebar-width: .*|\@sidebar-width: 300px;|g' assets/less/default/base.less
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

## serve resume (long)

```
docker run -it --rm -p 4000:4000 -v $(pwd):/app -w /app node:10 bash

npm install
export PATH=$PATH:$(pwd)/node_modules/.bin

sed -i "s|listen(port);|listen(port,'0.0.0.0');|g" node_modules/resume-cli/lib/serve.js
cd node_modules/jsonresume-theme-orbit
patch -p1 < ../../orbit-highlights.patch
perl -pi -e 's|\@sidebar-width: .*|\@sidebar-width: 300px;|g' assets/less/default/base.less
npm run build:styles:3
resume serve --resume ../../resume.json
```

## for printing

To print the resume I used the following settings in the Chrome print dialog:

![Print dialog settings](https://github.com/dakue/resume/raw/master/resume_print_dialog.png "Print dialog settings")

Apart from that you also need to set the media type to `screen` in the "Rendering" tab of the Dev tools. See [here](https://developers.google.com/web/tools/chrome-devtools/css/print-preview) how to accomplish this.

![CSS media type](https://github.com/dakue/resume/raw/master/resume_css_media_type.png "CSS media type")



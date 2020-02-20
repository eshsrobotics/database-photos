# Database-photos
* Please do not remove any photographs or folders unless you know what you're doing. They are used by various websites / resources
* If you are adding your own photographs and have the repository cloned, please run the program, if possible to create smaller files as thumbnails for websites

## usage
if you wish to only download the photos, and less of the history, perform a shallow clone

```sh
git clone --depth=1 https://github.com/eshsrobotics/database-photos
```

if you wish to only download the photos, less of the history, and only a subdirectory of the repository, perform a sparse checkout and a shallow clone

```sh
git init database-photos && cd database-photos
git remote add origin https://github.com/eshsrobotics/database-photos
git config core.sparsecheckout true
echo '2018-2019/*' >> .git/info/sparse-checkout
git pull --depth=1 origin master
```

Find
* 2016-2017 photograph archive
* 2017-2018 photograph archive
* 2018-2019 photograph archive
* Archive of unorginized photographs and photographs uploaded by the C.H.I.P.S. bot

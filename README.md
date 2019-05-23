# JS/CSS Minifier

Minify your JS/CSS files via [YUI Compressor](https://github.com/yui/yuicompressor "YUI Compressor")

## How does this work?

The script searches for JS/CSS files in the source directory and work them through YUI Compressor.

All others files will be copied.

## Using
```shell
sh minifier.sh
```

## Options
- `version` - path to version log

- `assets` - path to assets

- `compressor` - path to YUI Compressor


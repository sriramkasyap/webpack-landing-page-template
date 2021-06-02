#!/bin/bash

ht_path="/usr/local/var/www/"

alias www="cd /usr/local/var/www"

echo "Enter directory name"
read dir_name

echo "Enter Project title"
read page_title

project_name=$(echo $dir_name | cut -d'/' -f 2)
dir_path=$ht_path$dir_name
mkdir $dir_path

cd $dir_path

echo "Installing Bootstrap"
wget -q https://github.com/twbs/bootstrap/archive/v4.0.0.zip -O bootstrap.zip
unzip -q bootstrap.zip
rm $dir_path/bootstrap.zip
bootstrap_dir=$(find $dir_path -mindepth 1 -maxdepth 1 -type d)

echo "Creating inner directories"
mkdir src src/assets src/scss src/js 
touch .prettierrc .gitignore src/index.html src/scss/style.scss src/scss/_universal.scss src/scss/_style_xs.scss src/scss/_style_sm.scss src/scss/_style_md.scss src/scss/_style_lg.scss src/scss/_style_xl.scss  src/scss/_style_xxl.scss src/js/index.js webpack.dev.js webpack.common.js webpack.prod.js package.json

mv $bootstrap_dir/scss src/scss/bootstrap
mv src/scss/bootstrap/bootstrap-grid.scss src/scss/bootstrap/_bootstrap-grid.scss
mv src/scss/bootstrap/bootstrap-reboot.scss src/scss/bootstrap/_bootstrap-reboot.scss
mv src/scss/bootstrap/bootstrap.scss src/scss/bootstrap/_bootstrap.scss
rm -r $bootstrap_dir

echo "Writing index.html"
cat > src/index.html <<EOF
<!DOCTYPE html>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en">
   <![endif]-->
<!--[if IE 7]>
   <html class="no-js lt-ie9 lt-ie8" lang="en">
      <![endif]-->
<!--[if IE 8]>
      <html class="no-js lt-ie9" lang="en">
         <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en-US">
    <!--<![endif]-->
    <head>
        <meta charset="UTF-8" />
        <title>$page_title</title>
        <meta name="description" content="" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
    </head>
    <body>
    </body>
</html>

EOF

echo "Writing .prettierrc"
cat > .prettierrc <<EOF
{
    "tabWidth": 2,
    "semi": true,
    "singleQuote": false
}

EOF

echo "Writing .gitignore"
cat > .gitignore <<EOF
node_modules
build

EOF

echo "Writing style.scss"
cat > src/scss/style.scss <<EOF
@import 'bootstrap/bootstrap-grid';
@import 'universal';
@import 'style_xs';
@import 'style_sm';
@import 'style_md';
@import 'style_lg';
@import 'style_xl';
@import 'style_xxl';
EOF

echo "Writing _universal.scss"
cat > src/scss/_universal.scss <<EOF
//Imports
@import url("https://fonts.googleapis.com/css?family=Poppins:400,500");

//Variables
\$primary-font: "Poppins", sans-serif;
\$heading-font: "Poppins", sans-serif;
\$special-font: "Poppins", sans-serif;

\$primary-color: #000000;
\$secondary-color: #f1f7f9;
\$tertiary-color: #00b8e5;

\$special-color: #ed017f;
\$special-color-2: #353495;

\$text-black: #000000;
\$text-grey: #d3d1d3;

\$regular: 400;
\$bold: 500;
\$light: 300;

// Mixins

@mixin transition(\$timing, \$function) {
    transition: all \$timing \$function;
}

@mixin button(\$bg-color, \$bg-i-color, \$text-i-color) {
    padding: 10px 15px;
    text-align: center;
    display: inline-block;
    background-color: \$bg-color;
    border: 1px solid \$bg-color;
    @include transition(0.2s, ease-in-out);
    border-radius: 6px;
    cursor: pointer;
    &:hover,
    &:active,
    &:focus {
        background-color: \$bg-i-color;
        color: \$text-i-color;
    }
    &.hover-black {
        &:hover,
        &:active,
        &:focus {
            color: \$text-black;
        }
    }
}
@mixin flexbox() {
    display: flex;
    flex-wrap: wrap;
    flex-direction: row;
    align-items: flex-start;
}

@mixin gridbox() {
    display: grid;
}

body {
    margin: 0;
    font-family: \$primary-font;
    font-weight: \$regular;
    color: \$text-black;
}
p,
li,
a {
    font-size: 14px;
}
h1,
h2,
h3,
h4,
h5,
h6,
.heading-text {
    font-family: \$heading-font;
    font-weight: \$bold;
}
a {
    text-decoration: none;
    color: \$text-black;
}
img {
    display: block;
    max-width: 100%;
    max-height: 100%;
    user-select: none;
    height: auto;
    width: auto;
}
ul {
    margin: 0;
    padding: 0;
    &.show-bullets {
        padding-left: 15px;
        li {
            list-style-type: disc;
        }
    }
    li {
        list-style-type: none;
    }
}
input,
textarea,
select {
    outline: none;
    background: none;
    border: 0px;
    color: \$text-black;
    box-shadow: none;
    margin: 0;
    border-radius: 0;
    -webkit-appearance: textfield;
    font-family: \$primary-font;
    &:-moz-placeholder,
    &:-moz-placeholder,
    &::-ms-input-placeholder {
        font-family: \$primary-font;
    }
}
.special-font-text {
    font-family: \$special-font;
}
.light-text {
    font-weight: \$light;
}
.regular-text {
    font-weight: \$regular;
}
.regular-font-text {
    font-family: \$primary-font;
}
.bold-text {
    font-weight: \$bold;
}
.extra-bold-text {
    font-weight: 800;
}

.text-center {
    text-align: center;
}
.text-right {
    text-align: right;
}
.upper-text {
    text-transform: uppercase;
}
.cap-text {
    text-transform: capitalize;
}

.ml-auto {
    margin-left: auto;
}
.mr-auto {
    margin-right: auto;
}
.center-block,
.m-auto {
    display: block;
    @extend .ml-auto;
    @extend .mr-auto;
}
.w-100 {
    flex: 100%;
}

.primary-color-text {
    color: \$primary-color;
}
.secondary-color-text {
    color: \$secondary-color;
}
.tertiary-color-text {
    color: \$tertiary-color;
}
.special-color-text {
    color: \$special-color;
}
.grey-text {
    color: \$text-grey;
}
.white-text {
    color: white;
}

.primary-color-bg {
    background-color: \$primary-color;
}
.secondary-color-bg {
    background-color: \$secondary-color;
}
.tertiary-color-bg {
    background-color: \$tertiary-color;
}
.special-color-bg {
    background-color: \$special-color;
}
.special-color-2-bg {
    background-color: \$special-color-2;
}

.white-bg {
    background-color: #fff;
}

.primary-color-button {
    @include button(\$primary-color, transparent, \$primary-color);
}
.secondary-color-button {
    @include button(\$secondary-color, transparent, \$text-black);
}
.tertiary-color-button {
    @include button(\$tertiary-color, transparent, white);
}
.white-btn {
    @include button(white, transparent, \$primary-color);
}
EOF

echo "Writing _style_xs.scss"
cat > src/scss/_style_xs.scss <<EOF
@media only screen and (min-width: 0px) {
    .df {
        @include flexbox();
    }
}
EOF

echo "Writing _style_sm.scss"
cat > src/scss/_style_sm.scss <<EOF
@media only screen and (min-width: 576px) {
    .dfsm {
        @include flexbox();
    }
}
EOF

echo "Writing _style_md.scss"
cat > src/scss/_style_md.scss <<EOF
@media only screen and (min-width: 768px) {
    .dfmd {
        @include flexbox();
    }
}
EOF

echo "Writing _style_lg.scss"
cat > src/scss/_style_lg.scss <<EOF
@media only screen and (min-width: 992px) {
    .dflg {
        @include flexbox();
    }
}
EOF

echo "Writing _style_xl.scss"
cat > src/scss/_style_xl.scss <<EOF
@media only screen and (min-width: 1200px) {
    .dfxl {
        @include flexbox();
    }
}
EOF

echo "Writing _style_xxl.scss"
cat > src/scss/_style_xxl.scss <<EOF
@media only screen and (min-width: 1600px) {
    .dfxxl {
        @include flexbox();
    }
    .container {
        max-width: 1540px;
    }
}
EOF

echo "Creating index.js"
touch src/js/index.js


echo "Writing webpack.common.js"
cat > webpack.common.js <<EOF
    var path = require("path");
    var fs = require("fs");
    const HtmlWebpackPlugin = require("html-webpack-plugin");
    const { CleanWebpackPlugin } = require("clean-webpack-plugin");
    const MiniCssExtractPlugin = require("mini-css-extract-plugin");
    const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
    const TerserPlugin = require("terser-webpack-plugin");
    const webpack = require("webpack");

    var htmlFiles = fs
    .readdirSync(path.resolve(__dirname, "src"))
    .filter((fil) => fil.endsWith(".html"));

    module.exports = {
    entry: "./src/js/index.js",
    plugins: [
        new CleanWebpackPlugin(),
        new webpack.ProvidePlugin({
        $: require.resolve("jquery"),
        jQuery: require.resolve("jquery"),
        "window.jQuery": require.resolve("jquery"),
        }),
        ...htmlFiles.map((htm) => {
        return new HtmlWebpackPlugin({
            template: path.resolve(__dirname, "src", htm),
            filename: htm,
        });
        }),
    ],
    module: {
        rules: [
        {
            test: /\.scss/,
            use: [
            // Load css into seperate file
            MiniCssExtractPlugin.loader,
            // Translates CSS into CommonJS
            "css-loader",
            // Compiles Sass to CSS
            "sass-loader",
            ],
        },
        {
            test: /\.html/,
            use: ["html-loader"],
        },

        {
            test: /\.(png|jpg|gif)$/i,
            use: [
            {
                loader: "url-loader",
            },
            ],
            type: "javascript/auto",
        },
        ],
    },
    };

EOF

echo "Writing webpack.dev.js"
cat > webpack.dev.js <<EOF
    const MiniCssExtractPlugin = require("mini-css-extract-plugin");
    var { merge } = require("webpack-merge");
    var common = require("./webpack.common");
    const path = require("path");

    module.exports = merge(common, {
        mode: "development",
        output: {
            filename: "js/main.js",
            path: path.resolve(__dirname, "build"),
        },
        devtool: "source-map",
        plugins: [
            new MiniCssExtractPlugin({
            filename: "css/style.min.css",
            }),
        ],
    });

EOF

echo "Writing webpack.prod.js"
cat > webpack.prod.js <<EOF
    const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
    const MiniCssExtractPlugin = require("mini-css-extract-plugin");
    const TerserPlugin = require("terser-webpack-plugin");
    const { merge } = require("webpack-merge");
    const common = require("./webpack.common");
    const path = require("path");

    module.exports = merge(common, {
        mode: "production",
        output: {
            filename: "js/main.[hash].js",
            path: path.resolve(__dirname, "build"),
        },
        optimization: {
            minimizer: [
            new CssMinimizerPlugin(),
            new TerserPlugin(),
            ],
        },
        plugins: [
            new MiniCssExtractPlugin({
            filename: "css/style.[hash].css",
            }),
        ],
    });
EOF

echo "Writing to package.json"
cat > package.json <<EOF
{
    "name": "$project_name",
    "author": "Sriram Kasyap Meduri",
    "version": "1.0.4",
    "license": "GPL-2.0",
    "main": "src/js/index.js",
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1",
        "start": "webpack serve --open --config webpack.dev.js",
        "build": "webpack --config webpack.prod.js"
    },
    "dependencies": {
        "@popperjs/core": "^2.9.2",
        "bootstrap": "^5.0.1",
        "jquery": "^3.6.0"
    },
    "devDependencies": {
        "clean-webpack-plugin": "^4.0.0-alpha.0",
        "css-loader": "^5.2.6",
        "css-minimizer-webpack-plugin": "^3.0.1",
        "html-loader": "^2.1.2",
        "mini-css-extract-plugin": "^1.6.0",
        "node-sass": "^6.0.0",
        "sass-loader": "^12.0.0",
        "style-loader": "^2.0.0",
        "terser-webpack-plugin": "^5.1.3",
        "webpack": "^5.38.1",
        "webpack-cli": "^4.7.0",
        "webpack-dev-server": "^3.11.2",
        "webpack-merge": "^5.7.3",
        "html-webpack-plugin": "^5.3.1"
    }
}

EOF


code $dir_path
code $dir_path/src/index.html
code $dir_path/src/scss/_style_xs.scss
code $dir_path/src/scss/_universal.scss
code $dir_path/src/js/index.js


cd $dir_path


open $dir_path

echo "Installing NPM modules"
npm i && npm start

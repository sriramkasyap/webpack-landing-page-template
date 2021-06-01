var path = require("path");
var fs = require("fs");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");

var htmlFiles = fs
  .readdirSync(path.resolve(__dirname, "src"))
  .filter((fil) => fil.endsWith(".html"));

console.log("Templates:", htmlFiles);

module.exports = {
  mode: "production",
  entry: "./src/js/index.js",
  output: {
    filename: "js/main.js",
    path: path.resolve(__dirname, "build"),
  },
  devtool: "source-map",
  plugins: [
    new CleanWebpackPlugin(),
    new MiniCssExtractPlugin({
      filename: "css/style.min.css",
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
    ],
  },
  optimization: {
    minimizer: [
      // For webpack@5 you can use the `...` syntax to extend existing minimizers (i.e. `terser-webpack-plugin`), uncomment the next line
      // `...`,
      new CssMinimizerPlugin(),
      new TerserPlugin(),
    ],
  },
};

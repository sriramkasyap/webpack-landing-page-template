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

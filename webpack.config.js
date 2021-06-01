var path = require("path");
var fs = require("fs");
const HtmlWebpackPlugin = require("html-webpack-plugin");

var htmlFiles = fs
  .readdirSync(path.resolve(__dirname, "src"))
  .filter((fil) => fil.endsWith(".html"));

console.log("Templates:", htmlFiles);

module.exports = {
  mode: "development",
  entry: "./src/js/index.js",
  output: {
    filename: "js/main.js",
    path: path.resolve(__dirname, "build"),
  },
  devtool: "source-map",
  plugins: [
    ...htmlFiles.map((htm) => {
      return new HtmlWebpackPlugin({
        template: path.resolve(__dirname, "src", htm),
        filename: htm,
      });
    }),
  ],
};

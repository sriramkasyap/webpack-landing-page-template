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

module.exports = {
  entry: "./src/js/index.js",
  plugins: [
    new CleanWebpackPlugin(),

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

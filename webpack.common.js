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
  entry: "./src/index.js",
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
          {
            loader: "postcss-loader", // Run post css actions
            options: {
              postcssOptions: {
                plugins: [require("autoprefixer")],
              },
            },
          },
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
        type: "asset/resource",
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/i,
        type: "asset/resource",
      },
    ],
  },
};

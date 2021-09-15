/* eslint-disable */
const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const ForkTsCheckerWebpackPlugin = require("fork-ts-checker-webpack-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const CompressionPlugin = require("compression-webpack-plugin");

const DEV = process.env.NODE_ENV !== "production";

module.exports = {
  devtool: DEV ? "inline-source-map" : false,
  entry: {
    app: "./src/app.tsx",
  },
  output: {
    filename: "[name].js",
    chunkFilename: "[id].js",
    publicPath: "/bundle/",
    path: path.resolve(__dirname, "../priv/static/bundle"),
  },
  resolve: {
    extensions: [".mjs", ".js", ".jsx", ".ts", ".tsx"],
  },
  optimization: {
    minimizer: [new TerserPlugin(), new CssMinimizerPlugin()],
  },
  module: {
    rules: [
      {
        test: /\.[tj]sx?$/,
        loader: "esbuild-loader",
        exclude: /node_modules/,
        options: {
          loader: "tsx",
          target: "es2015",
        },
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: [
          {
            loader: "file-loader",
            options: {
              name: "[name].[ext]",
              outputPath: "fonts/",
              publicPath: "/bundle/fonts/",
            },
          },
        ],
      },
      {
        test: /\.(jp(e)?g|png)(\?v=\d+\.\d+\.\d+)?$/,
        use: [
          {
            loader: "file-loader",
            options: {
              name: "[name].[ext]",
              outputPath: "images/",
              publicPath: "/bundle/images/",
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new ForkTsCheckerWebpackPlugin({
      eslint: {
        enabled: true,
        files: "./src/**/*.{ts,tsx,js,jsx}",
      },
    }),
    new MiniCssExtractPlugin({
      filename: "[name].css",
      chunkFilename: "[id].css",
    }),
    new CopyWebpackPlugin({
      patterns: [{ from: "static/", to: "../", noErrorOnMissing: true }],
    }),
    !DEV
      ? new CompressionPlugin({
          filename: "[path][base].gz",
          test: /\.(js|css|html|svg)$/,
          algorithm: "gzip",
        })
      : false,
    !DEV
      ? new CompressionPlugin({
          filename: "[path][base].br",
          test: /\.(js|css|html|svg)$/,
          algorithm: "brotliCompress",
        })
      : false,
  ].filter(Boolean),
};

const path = require("path");

const staticPath = path.join(__dirname, "static");
const appBasePath = path.join(staticPath, "app");

module.exports = {
  entry: path.join(appBasePath, "index.js"),
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        options: { presets: ["@babel/preset-env", "@babel/preset-react"] },
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
    ],
  },
  output: {
    filename: "index-bundle.js",
    path: path.join(staticPath, "dist"),
  },
};

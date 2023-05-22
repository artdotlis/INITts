const Path = require('path');
const TerserPlugin = require('terser-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyPlugin = require('copy-webpack-plugin');
const PrConf = require('./project.json');

function createCopyPath() {
    const path = [];
    for (const type in PrConf.copy) {
        for (const frto in PrConf.copy[type]) {
            path.push(PrConf.copy[type][frto]);
        }
    }
    return path;
}

function getMode() {
    if (PrConf.production) {
        return 'production';
    }
    return 'development';
}

module.exports = {
    mode: getMode(),
    entry: {
        index: './src/initts/js/index.js',
    },
    output: {
        filename: 'js/[name].bundle.js',
        path: Path.resolve(__dirname, '../../public/initts/'),
        publicPath: '/',
    },
    optimization: {
        runtimeChunk: 'single',
        splitChunks: { chunks: 'all' },
        // TODO: Enable in prod mode
        minimize: PrConf.production,
        minimizer: [
            new TerserPlugin({
                extractComments: /^\**!|@preserve|@license|@cc_on/i,
            }),
        ],
    },
    plugins: [
        new HtmlWebpackPlugin({
            filename: 'index.html',
            template: './src/initts/html/index.html',
            chunks: ['runtime', 'index'],
        }),
        new MiniCssExtractPlugin({
            filename: './css/[name].[fullhash].bundle.css',
        }),
        new CopyPlugin({
            patterns: createCopyPath(),
        }),
    ],
    module: {
        rules: [
            {
                test: /\.css$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    {
                        loader: 'css-loader',
                        options: {
                            importLoaders: 0,
                            modules: false,
                        },
                    },
                ],
                exclude: /\.module\.css$/,
            },
            {
                test: /\.module\.css$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    {
                        loader: 'css-loader',
                        options: {
                            importLoaders: 1,
                            modules: true,
                        },
                    },
                ],
            },
            {
                test: /\.(woff|woff2|eot|ttf|otf)$/,
                type: 'asset/resource',
                generator: {
                    filename: 'fonts/[hash][ext][query]',
                },
            },
            {
                test: /\.(jpg|png)$/,
                type: 'asset/resource',
                generator: {
                    filename: 'img/[hash][ext][query]',
                },
            },
        ],
    },
};

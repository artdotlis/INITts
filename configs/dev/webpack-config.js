import * as PrConf from './project.json' assert { type: 'json' };
import Path from 'path';
import HtmlWebpackPlugin from 'html-webpack-plugin';
import CopyPlugin from 'copy-webpack-plugin';
import TerserPlugin from 'terser-webpack-plugin';
import MiniCssExtractPlugin from 'mini-css-extract-plugin';

function createCopyPath() {
    const path = [];
    const defC = PrConf.default.copy;
    for (const type in defC) {
        for (const frto in defC[type]) {
            path.push(defC[type][frto]);
        }
    }
    return path;
}

function getMode() {
    if (PrConf.default.production) {
        return 'production';
    }
    return 'development';
}

const config = {
    target: 'web',
    resolve: {
        extensions: ['.js'],
        alias: {
            '@initts/src': Path.resolve(process.cwd(), 'src/initts/js/'),
            '@initts/root': Path.resolve(process.cwd(), 'src/initts/'),
            '@extra': Path.resolve(process.cwd(), 'extra/'),
            '@configs': Path.resolve(process.cwd(), 'configs/'),
            '@assets': Path.resolve(process.cwd(), 'assets/'),
        },
    },
    mode: getMode(),
    entry: {
        index: './src/initts/js/index.js',
    },
    output: {
        filename: 'js/[name].bundle.js',
        path: Path.resolve(process.cwd(), 'public/initts/'),
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
            {
                test: /\.js$/,
                use: [
                    {
                        loader: 'babel-loader',
                        options: {
                            presets: [
                                ['@babel/preset-env', { targets: '>0.5%, not dead' }],
                            ],
                        },
                    },
                ],
            },
        ],
    },
};

export default config;

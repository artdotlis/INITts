import PrConf from '../../src/initts/ts/configs/project.js';
import Path from 'path';
import HtmlWebpackPlugin from 'html-webpack-plugin';
import CopyPlugin from 'copy-webpack-plugin';
import TerserPlugin from 'terser-webpack-plugin';
import MiniCssExtractPlugin from 'mini-css-extract-plugin';
import { PurgeCSSPlugin } from 'purgecss-webpack-plugin';
import {globSync} from 'glob';

function createCopyPath() {
    const path = [];
    const defC = PrConf.copy;
    for (const type in defC) {
        for (const frto in defC[type]) {
            path.push(defC[type][frto]);
        }
    }
    return path;
}

const BOpt = {
    presets: [
        ['@babel/preset-env', { targets: '>0.5%, not dead' }],
    ],
}

function getMode() {
    if (PrConf.production) {
        return 'production';
    }
    return 'development';
}

const config = {
    target: 'web',
    resolve: {
        extensions: [".tsx", ".ts", ".js"],
        alias: {
            '@initts/src': Path.resolve(process.cwd(), 'src/initts/ts/'),
            '@initts/root': Path.resolve(process.cwd(), 'src/initts/'),
            '@extra': Path.resolve(process.cwd(), 'extra/'),
            '@configs': Path.resolve(process.cwd(), 'configs/'),
            '@assets': Path.resolve(process.cwd(), 'assets/'),
        },
    },
    mode: getMode(),
    entry: {
        index: './src/initts/ts/index.ts',
    },
    output: {
        filename: 'js/[name].[chunkhash].bundle.js',
        path: Path.resolve(process.cwd(), 'public/initts/'),
        publicPath: '/',
    },
    optimization: {
        runtimeChunk: 'single',
        splitChunks: { 
            cacheGroups: {
                vendor: {
                    test: /[\\/]node_modules[\\/]/,
                    chunks: "all"
                },
                style: {
                    name: 'style',
                    test: /(?<!\.module)\.css$/,
                    chunks: 'all',
                    enforce: true
                }
            },
        },
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
            template: 'src/initts/html/index.html',
            chunks: ['index']
        }),
        new MiniCssExtractPlugin({
            filename: 'css/[name].[chunkhash].bundle.css',
        }),
        new PurgeCSSPlugin({
            paths: globSync(`${process.cwd()}/src/initts/**/*`,  { nodir: true }),
            only: ["vendor", "style"],
        }),
        new CopyPlugin({
            patterns: createCopyPath(),
        }),
    ],
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: [                    
                    {
                        loader: 'babel-loader',
                        options: BOpt,
                    },
                    { 
                        loader: 'ts-loader',
                        options: {
                            configFile: Path.resolve(process.cwd(), 'configs/dev/tsconfig.json')
                        }
                    }
                ],
            },
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
                        options: BOpt,
                    },
                ],
            },
            
        ],
    },
};

export default config;

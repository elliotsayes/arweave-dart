const esbuild = require('esbuild');
// const { nodeExternalsPlugin } = require('esbuild-node-externals');

const build = () => {
  esbuild.build({
    entryPoints: ['./src/index.ts'],
    outfile: 'dist/arweave-wallet.js',
    bundle: true,
    minify: true,
    treeShaking: true,
    globalName: 'ArweaveWallet',
    inject: ['./scripts/inject.js'],
    // platform: 'node',
    // format: 'cjs',
    // target: 'node14',
    // plugins: [nodeExternalsPlugin()],
  });
};

build();

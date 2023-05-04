// Source: https://github.com/Bundlr-Network/arbundles/blob/master/src/constants.ts

// export enum SignatureConfig {
//   ARWEAVE = 1,
//   ED25519,
//   ETHEREUM,
//   SOLANA,
//   INJECTEDAPTOS = 5,
//   MULTIAPTOS = 6,
//   TYPEDETHEREUM = 7,
// }

// export interface SignatureMeta {
//   sigLength: number;
//   pubLength: number;
//   sigName: string;
// }

// export const SIG_CONFIG: Record<SignatureConfig, SignatureMeta> = {
//   [SignatureConfig.ARWEAVE]: {
//     sigLength: 512,
//     pubLength: 512,
//     sigName: "arweave",
//   },
//   [SignatureConfig.ED25519]: {
//     sigLength: 64,
//     pubLength: 32,
//     sigName: "ed25519",
//   },
//   [SignatureConfig.ETHEREUM]: {
//     sigLength: 65,
//     pubLength: 65,
//     sigName: "ethereum",
//   },
//   [SignatureConfig.SOLANA]: {
//     sigLength: 64,
//     pubLength: 32,
//     sigName: "solana",
//   },
//   [SignatureConfig.INJECTEDAPTOS]: {
//     sigLength: 64,
//     pubLength: 32,
//     sigName: "injectedAptos",
//   },
//   [SignatureConfig.MULTIAPTOS]: {
//     sigLength: 64 * 32 + 4, // max 32 64 byte signatures, +4 for 32-bit bitmap
//     pubLength: 32 * 32 + 1, // max 64 32 byte keys, +1 for 8-bit threshold value
//     sigName: "multiAptos",
//   },
//   [SignatureConfig.TYPEDETHEREUM]: {
//     sigLength: 65,
//     pubLength: 42,
//     sigName: "typedEthereum",
//   },
// };

enum ChainCode {
  Unknown, // 0
  Arweave, // 1
  Curve25519, // 2
  Ethereum, // 3
  Solana, // 4
  Aptos, // 5
  MultiSignatureAptos, // 6
  TypedEthereum, // 7
}

class ChainConfig {
  final ChainCode code;
  final String name;
  final int pubkeyLengthBytes;
  final int signatureLengthBytes;

  ChainConfig({
    required this.code,
    required this.name,
    required this.pubkeyLengthBytes,
    required this.signatureLengthBytes
  });
}

final arweaveConfig = ChainConfig(
  code: ChainCode.Arweave,
  name: 'arweave',
  pubkeyLengthBytes: 512,
  signatureLengthBytes: 512,
);

final curve25519Config = ChainConfig(
  code: ChainCode.Curve25519,
  name: 'curve25519',
  pubkeyLengthBytes: 32,
  signatureLengthBytes: 64,
);

final ethereumConfig = ChainConfig(
  code: ChainCode.Ethereum,
  name: 'ethereum',
  pubkeyLengthBytes: 65,
  signatureLengthBytes: 65,
);

final solanaConfig = ChainConfig(
  code: ChainCode.Solana,
  name: 'solana',
  pubkeyLengthBytes: 32,
  signatureLengthBytes: 64,
);

final aptosConfig = ChainConfig(
  code: ChainCode.Aptos,
  name: 'aptos',
  pubkeyLengthBytes: 32,
  signatureLengthBytes: 64,
);

final multiSignatureAptosConfig = ChainConfig(
  code: ChainCode.MultiSignatureAptos,
  name: 'multiAptos',
  pubkeyLengthBytes: 32 * 32 + 1,
  signatureLengthBytes: 64 * 32 + 4,
);

final typedEthereumConfig = ChainConfig(
  code: ChainCode.TypedEthereum,
  name: 'typedEthereum',
  pubkeyLengthBytes: 42,
  signatureLengthBytes: 65,
);

final Map<ChainCode, ChainConfig> chainConfigMap = {
  ChainCode.Arweave: arweaveConfig,
  // ChainCode.Curve25519: curve25519Config,
  ChainCode.Ethereum: ethereumConfig,
  // ChainCode.Solana: solanaConfig,
  // ChainCode.Aptos: aptosConfig,
  // ChainCode.MultiSignatureAptos: multiSignatureAptosConfig,
  // ChainCode.TypedEthereum: typedEthereumConfig,
};

import 'package:arweave/src/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

class Wallet {
  String get owner => encodeBigIntToBase64(_publicKey.n);
  String get address => encodeBytesToBase64(
      sha256.convert(encodeBigIntToBytes(_publicKey.n)).bytes);

  RSAPublicKey _publicKey;
  RSAPrivateKey _privateKey;

  Wallet({RSAPublicKey publicKey, RSAPrivateKey privateKey})
      : _publicKey = publicKey,
        _privateKey = privateKey;

  factory Wallet.fromJwk(Map<String, dynamic> jwk) {
    final modulus = decodeBase64ToBigInt(jwk['n']);

    return Wallet(
      publicKey: RSAPublicKey(
        modulus,
        decodeBase64ToBigInt(jwk['e']),
      ),
      privateKey: RSAPrivateKey(
        modulus,
        decodeBase64ToBigInt(jwk['d']),
        decodeBase64ToBigInt(jwk['p']),
        decodeBase64ToBigInt(jwk['q']),
      ),
    );
  }

  Map<String, dynamic> toJwk() => {
        'kty': 'RSA',
        'e': encodeBigIntToBase64(_publicKey.e),
        'n': encodeBigIntToBase64(_publicKey.n),
        'd': encodeBigIntToBase64(_privateKey.d),
        'p': encodeBigIntToBase64(_privateKey.p),
        'q': encodeBigIntToBase64(_privateKey.q),
      };
}
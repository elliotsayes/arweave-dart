import 'dart:typed_data';

import 'package:arweave/src/crypto/hmac_drbg_secure_random.dart';
import 'package:bip39/bip39.dart';
import 'package:pointycastle/export.dart';
import 'package:test/test.dart';

void main() {
  // test('HmacDrbgSecureRandom returns same type data as FortunaRandom',
  //     () async {
  //   final seed = Uint8List.fromList(List.generate(64, (i) => 0));
  //   final secureRandom = HmacDrbgSecureRandom();
  //   secureRandom.seed(KeyParameter(Uint8List.fromList(seed)));

  //   // TODO: figure out why bit length appears to be 2047 or 2048 depending on
  //   // seed
  //   final seedFortuna = Uint8List.fromList(List.generate(32, (i) => 1));
  //   final fortunaRandom = FortunaRandom();
  //   fortunaRandom.seed(KeyParameter(Uint8List.fromList(seedFortuna)));

  //   final bigIntHmac = secureRandom.nextBigInteger(2048);
  //   final bigIntFortuna = fortunaRandom.nextBigInteger(2048);

  //   expect(bigIntFortuna.bitLength, equals(2048));
  //   expect(bigIntHmac.bitLength, equals(2048));
  //   expect(bigIntHmac.bitLength, equals(bigIntFortuna.bitLength));
  // }, onPlatform: {
  //   'browser': Skip('dart:io unavailable'),
  // });

  test('HmacDrbgSecureRandom returns same bytes from 1-filled seed as JS',
      () async {
    final seed = Uint8List.fromList(List<int>.generate(64, (i) => 1));
    final secureRandom = HmacDrbgSecureRandom();

    secureRandom.seed(KeyParameter(seed));

    final bytes = secureRandom.nextBytes(8);

    const expected = [34, 199, 111, 231, 149, 69, 120, 221];
    expect(bytes, equals(Uint8List.fromList(expected)));
  }, onPlatform: {
    'browser': Skip('dart:io unavailable'),
  });

  test('HmacDrbgSecureRandom returns same bytes from seed as JS', () async {
    final testArweaveAppWalletMnemonic =
        "child collect expose tunnel youth response idle suspect accuse drink clip athlete";
    final seed = mnemonicToSeed(testArweaveAppWalletMnemonic);
    final secureRandom = HmacDrbgSecureRandom();
    secureRandom.seed(KeyParameter(seed));

    final bytes = secureRandom.nextBytes(8);

    const expected = [3, 141, 196, 54, 177, 78, 115, 59];
    expect(bytes, equals(Uint8List.fromList(expected)));
  }, onPlatform: {
    'browser': Skip('dart:io unavailable'),
  });
}

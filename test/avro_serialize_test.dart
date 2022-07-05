import 'dart:typed_data';

import 'package:arweave/src/utils/avro_serialize.dart';
import 'package:test/test.dart';

void main() {
  // Test case from https://avro.apache.org/docs/current/spec.html#binary_encode_complex
  test('should serialize array correctly', () {
    final tEncodedArray = <int>[0x06, 0x36].map(
      (encodedItem) => Uint8List.fromList([encodedItem]),
    );
    final res = serializeArray(tEncodedArray);
    expect(res, equals(Uint8List.fromList([0x04, 0x06, 0x36, 0x00])));
  });

  // Test case from https://avro.apache.org/docs/current/spec.html#binary_encode_primitive
  test('should serialize string correctly', () {
    final tString = 'foo';
    final res = serializeString(tString);
    expect(res, equals(Uint8List.fromList([0x06, 0x66, 0x6f, 0x6f])));
  });

  // Test cases from https://avro.apache.org/docs/current/spec.html#binary_encode_primitive
  group('serialize long', () {
    test('should serialize low positive long correctly', () {
      final tLowLong = 2;
      final res = serializeLong(tLowLong);
      expect(res, equals(Uint8List.fromList([0x04])));
    });

    test('should serialize negative long correctly', () {
      final tNegativeLong = -64;
      final res = serializeLong(tNegativeLong);
      expect(res, equals(Uint8List.fromList([0x7f])));
    });

    test('should serialize 8-bit long correctly', () {
      final tTwoByteLong = 64;
      final res = serializeLong(tTwoByteLong);
      expect(res, equals(Uint8List.fromList([0x80, 0x01])));
    });
  });
}

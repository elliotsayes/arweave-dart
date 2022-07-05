import 'dart:convert';
import 'dart:typed_data';

Uint8List serializeArray(Iterable<Uint8List> array) {
  final concatBuffer = <int>[];
  for (final element in array) {
    concatBuffer.addAll(element);
  }

  return Uint8List.fromList(
    serializeLong(array.length) + concatBuffer + [0],
  );
}

Uint8List serializeString(String string) {
  final stringBytes = utf8.encode(string);

  return Uint8List.fromList(
    serializeLong(stringBytes.length) + stringBytes,
  );
}

const _msb = 0x80;

Uint8List serializeLong(int long) {
  var zigZag = (long << 1) ^ (long >> 63);

  final builder = BytesBuilder();
  while (zigZag >= _msb) {
    builder.addByte(zigZag | _msb);
    zigZag >>= 7;
  }
  builder.addByte(zigZag);

  return builder.toBytes();
}

import 'dart:typed_data';

import 'package:arweave/src/models/tag.dart';
import 'package:arweave/src/utils.dart';
import 'package:arweave/src/utils/avro_serialize.dart';

Uint8List serializeTags({required List<Tag> tags}) {
  final decodedTags = <Tag>[];
  for (var tag in tags) {
    decodedTags.add(Tag(
      decodeBase64ToString(tag.name),
      decodeBase64ToString(tag.value),
    ));
  }
  final avroTags = decodedTags.map(_serializeTag);
  final avroTagArray = serializeArray(avroTags);

  return avroTagArray;
}

Uint8List _serializeTag(Tag tag) {
  return Uint8List.fromList(
    serializeString(tag.name) + serializeString(tag.value),
  );
}

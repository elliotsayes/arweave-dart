@TestOn('browser')

import 'dart:typed_data';

import 'package:arweave/src/utils/bundle_tag_parser.dart';
import 'package:arweave/src/models/tag.dart';
import 'package:arweave/utils.dart';
import 'package:test/test.dart';

import 'snapshots/data_bundle_test_snaphot.dart';
import 'deserialize_tags.dart';

void main() {
  group('serializeTags function', () {
    test('serializes snapshot tags correctly', () {
      final buffer = serializeTags(tags: testTagsSnapshot);
      expect(buffer, equals(testTagsBufferSnapshot));
    });

    test(
        'throws an exception when not base64 encoded strings are used to create a tag',
        () {
      final tags = [Tag('not encoded', 'tag')];

      expect(
        () => serializeTags(tags: tags),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('deserializeTags function', () {
    test(
        'throws an exception when input data is not Uint8List from base64Url encoded string',
        () {
      final testTags = [
        Tag(encodeStringToBase64('random-tag'),
            encodeStringToBase64('random-tag'))
      ];
      final buffer = serializeTags(tags: testTags);
      final badTagBuffer = [Uint8List.fromList(buffer), 0];

      expect(
        () => deserializeTags(buffer: badTagBuffer),
        throwsA(isA<WrongTagBufferException>()),
      );
    });

    test('correctly deserializes snapshot data', () {
      final tags = deserializeTags(buffer: testTagsBufferSnapshot);
      expect(tags, equals(testTagsSnapshot));
    });
  });
}

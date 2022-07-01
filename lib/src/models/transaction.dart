import 'dart:convert';
import 'dart:typed_data';

import 'package:arweave/arweave.dart';
import 'package:arweave/src/models/currency.dart';
import 'package:json_annotation/json_annotation.dart';

import '../crypto/crypto.dart';
import '../utils.dart';
import '../utils/bundle_tag_parser.dart';

part 'transaction.g.dart';

String _bigIntToString(BigInt v) => v.toString();
BigInt _stringToBigInt(String v) => BigInt.parse(v);

@JsonSerializable()
class Transaction implements TransactionBase {
  @JsonKey(defaultValue: 1)
  final int format;

  @override
  String get id => _id;
  late String _id;

  @JsonKey(name: 'last_tx')
  String? get lastTx => _lastTx;
  String? _lastTx;

  @override
  String? get owner => _owner;
  String? _owner;

  @override
  List<Tag> get tags => _tags;
  late List<Tag> _tags;

  @override
  String get target => _target;
  String _target;

  @JsonKey(fromJson: _stringToBigInt, toJson: _bigIntToString)
  BigInt get quantity => _quantity;
  BigInt _quantity;

  /// The unencoded data associated with this [Transaction].
  ///
  /// This data is persisted unencoded to avoid having to convert it back from Base64 when signing.
  @override
  Uint8List get data => _data;
  Uint8List _data;

  @JsonKey(name: 'data_size')
  String get dataSize => _dataSize;
  String _dataSize = '0';

  @JsonKey(name: 'data_root')
  String get dataRoot => _dataRoot;
  late String _dataRoot;

  @JsonKey(fromJson: _stringToBigInt, toJson: _bigIntToString)
  BigInt get reward => _reward;
  late BigInt _reward;

  @override
  String get signature => _signature;
  late String _signature;

  @JsonKey(ignore: true)
  Currency get signerCurrency => _signerCurrency;
  late Currency _signerCurrency;

  @JsonKey(ignore: true)
  TransactionChunksWithProofs? get chunks => _chunks;
  TransactionChunksWithProofs? _chunks;

  /// This constructor is reserved for JSON serialisation.
  ///
  /// [Transaction.withJsonData()] and [Transaction.withBlobData()] are the recommended ways to construct data transactions.
  /// This constructor will not compute the data size or encode incoming data to Base64 for you.
  Transaction({
    this.format = 2,
    String? id,
    String? lastTx,
    String? owner,
    List<Tag>? tags,
    String? target,
    BigInt? quantity,
    String? data,
    Uint8List? dataBytes,
    String? dataSize,
    String? dataRoot,
    BigInt? reward,
    String? signature,
  })  : _target = target ?? '',
        _quantity = quantity ?? BigInt.zero,
        _data = data != null
            ? decodeBase64ToBytes(data)
            : (dataBytes ?? Uint8List(0)),
        _dataRoot = dataRoot ?? '',
        _reward = reward ?? BigInt.zero,
        _owner = owner,
        _lastTx = lastTx {
    if (signature != null) {
      _signature = signature;
    }
    if (dataSize != null) {
      _dataSize = dataSize;
    }
    if (id != null) {
      _id = id;
    }

    _tags = tags != null ? [...tags] : [];
  }

  /// Constructs a [Transaction] with the specified [DataBundle], computed data size, and appropriate bundle tags.
  factory Transaction.withDataBundle({
    String? owner,
    List<Tag>? tags,
    String? target,
    BigInt? quantity,
    required Uint8List bundleBlob,
    BigInt? reward,
  }) =>
      Transaction.withBlobData(
        owner: owner,
        tags: tags,
        target: target,
        quantity: quantity,
        data: bundleBlob,
        reward: reward,
      )
        ..addTag('Bundle-Format', 'binary')
        ..addTag('Bundle-Version', '2.0.0');

  /// Constructs a [Transaction] with the specified JSON data, computed data size, and Content-Type tag.
  factory Transaction.withJsonData({
    String? owner,
    List<Tag>? tags,
    String? target,
    BigInt? quantity,
    required Object data,
    BigInt? reward,
  }) =>
      Transaction.withBlobData(
        owner: owner,
        tags: tags,
        target: target,
        quantity: quantity,
        data: utf8.encode(json.encode(data)) as Uint8List,
        reward: reward,
      )..addTag('Content-Type', 'application/json');

  /// Constructs a [Transaction] with the specified blob data and computed data size.
  factory Transaction.withBlobData({
    String? owner,
    List<Tag>? tags,
    String? target,
    BigInt? quantity,
    required Uint8List data,
    BigInt? reward,
  }) =>
      Transaction(
        owner: owner,
        tags: tags,
        target: target,
        quantity: quantity,
        dataBytes: data,
        dataSize: data.lengthInBytes.toString(),
        reward: reward,
      );

  void setLastTx(String lastTx) => _lastTx = lastTx;

  void setTarget(String target) => _target = target;

  void setQuantity(BigInt quantity) => _quantity = quantity;

  @override
  void setOwner(String owner) => _owner = owner;

  /// Sets the data and data size of this [Transaction].
  ///
  /// Also chunks and validates the incoming data for format 2 transactions.
  Future<void> setData(Uint8List data) async {
    _data = data;
    _dataSize = data.lengthInBytes.toString();

    if (format == 2) {
      final existingDataRoot = _dataRoot;
      _chunks = null;

      await prepareChunks();

      if (existingDataRoot != dataRoot) {
        throw StateError(
            'Incoming data does not match data transaction was prepared with.');
      }
    }
  }

  @override
  void addTag(String name, String value) {
    tags.add(
      Tag(
        encodeStringToBase64(name),
        encodeStringToBase64(value),
      ),
    );
  }

  void setReward(BigInt reward) => _reward = reward;

  Future<void> prepareChunks() async {
    if (chunks != null) return;

    if (data.isNotEmpty) {
      _chunks = await generateTransactionChunks(data);
      _dataRoot = encodeBytesToBase64(chunks!.dataRoot);
    } else {
      _chunks = TransactionChunksWithProofs(Uint8List(0), [], []);
    }
  }

  /// Returns a chunk in a format suitable for posting to /chunk.
  TransactionChunk getChunk(int index) {
    if (chunks == null) throw StateError('Chunks have not been prepared.');

    final proof = chunks!.proofs[index];
    final chunk = chunks!.chunks[index];

    return TransactionChunk(
      dataRoot: dataRoot,
      dataSize: dataSize,
      dataPath: encodeBytesToBase64(proof.proof),
      offset: proof.offset.toString(),
      chunk: encodeBytesToBase64(
          Uint8List.sublistView(data, chunk.minByteRange, chunk.maxByteRange)),
    );
  }

  @override
  Future<Uint8List> getSignatureData() async {
    switch (format) {
      case 1:
        return Uint8List.fromList(
          decodeBase64ToBytes(owner!) +
              decodeBase64ToBytes(target) +
              data +
              utf8.encode(quantity.toString()) +
              utf8.encode(reward.toString()) +
              decodeBase64ToBytes(lastTx!) +
              tags
                  .expand((t) =>
                      decodeBase64ToBytes(t.name) +
                      decodeBase64ToBytes(t.value))
                  .toList(),
        );
      case 2:
        return deepHash([
          utf8.encode(format.toString()),
          decodeBase64ToBytes(owner!),
          decodeBase64ToBytes(target),
          utf8.encode(quantity.toString()),
          utf8.encode(reward.toString()),
          decodeBase64ToBytes(lastTx!),
          tags
              .map(
                (t) => [
                  decodeBase64ToBytes(t.name),
                  decodeBase64ToBytes(t.value),
                ],
              )
              .toList(),
          utf8.encode(dataSize),
          decodeBase64ToBytes(dataRoot),
        ]);
      default:
        throw Exception('Unexpected transaction format!');
    }
  }

  @override
  Future<void> sign(Wallet wallet) async {
    final signatureData = await getSignatureData();
    final rawSignature = await wallet.sign(signatureData);

    _signature = encodeBytesToBase64(rawSignature);
    _signerCurrency = wallet.currency;

    final idHash = await sha256.hash(rawSignature);
    _id = encodeBytesToBase64(idHash.bytes);
  }

  @override
  Future<bool> verify() async {
    try {
      final signatureData = await getSignatureData();
      final claimedSignatureBytes = decodeBase64ToBytes(signature);

      final idHash = await sha256.hash(claimedSignatureBytes);
      final expectedId = encodeBytesToBase64(idHash.bytes);

      if (id != expectedId) return false;

      return rsaPssVerify(
        input: signatureData,
        signature: claimedSignatureBytes,
        modulus: decodeBase64ToBigInt(owner!),
        publicExponent: publicExponent,
      );
    } catch (_) {
      return false;
    }
  }

  Future<BytesBuilder> asBinary() async {
    assert(await verify());

    final decodedOwner = decodeBase64ToBytes(owner!);
    final decodedTarget = decodeBase64ToBytes(target);
    final anchor = decodeBase64ToBytes(lastTx!);
    final tags = serializeTags(tags: this.tags);

    // See [https://github.com/joshbenaron/arweave-standards/blob/ans104/ans/ANS-104.md#13-dataitem-format]
    assert(decodedOwner.buffer.lengthInBytes == 512);
    final bytesBuilder = BytesBuilder();

    bytesBuilder.add(shortTo2ByteArray(1)); // Signature type: AR
    bytesBuilder.add(decodeBase64ToBytes(signature));
    bytesBuilder.add(decodedOwner);
    bytesBuilder.addByte(decodedTarget.isNotEmpty ? 1 : 0);

    if (decodedTarget.isNotEmpty) {
      assert(
          decodedTarget.lengthInBytes == 32, print('Target must be 32 bytes'));
      bytesBuilder.add(decodedTarget);
    }

    bytesBuilder.addByte(anchor.isNotEmpty ? 1 : 0);
    if (anchor.isNotEmpty) {
      assert(
          anchor.buffer.lengthInBytes == 32, print('Anchor must be 32 bytes'));
      bytesBuilder.add(anchor);
    }

    bytesBuilder.add(longTo8ByteArray(this.tags.length));
    final bytesCount = longTo8ByteArray(tags.lengthInBytes);
    bytesBuilder.add(bytesCount);
    if (tags.isNotEmpty) {
      bytesBuilder.add(tags);
    }

    bytesBuilder.add(data);

    final length = bytesBuilder.length;

    final signatureLength = decodeBase64ToBytes(signature).length;
    final expectedLength = 2 +
        signatureLength +
        decodedOwner.length +
        (1 + decodedTarget.length) +
        (1 + anchor.length) +
        (16 + tags.length) +
        data.length;

    assert(length == expectedLength);

    return bytesBuilder;
  }

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  /// Encodes the [Transaction] as JSON with the `data` as the original unencoded [Uint8List].
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

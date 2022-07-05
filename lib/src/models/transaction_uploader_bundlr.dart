import 'dart:async';

import 'package:arweave/arweave.dart';
import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/models/transaction_uploader_base.dart';

class TransactionUploaderBundlr extends TransactionUploader {
  final DataItem _dataItem;
  final BundlrApi _bundlr;

  @override
  bool get isComplete => _done;
  @override
  int get totalChunks => 1;
  @override
  int get uploadedChunks => _done ? 1 : 0;
  @override
  double get progress => _done ? 1 : 0;

  final int maxConcurrentChunkUploadCount;

  bool _txPosted = false;
  bool _done = false;

  TransactionUploaderBundlr(
    DataItem dataItem,
    BundlrApi api, {
    this.maxConcurrentChunkUploadCount = 128,
    bool forDataOnly = false,
  })  : _dataItem = dataItem,
        _bundlr = api,
        _txPosted = forDataOnly;

  @override
  Stream<TransactionUploaderBundlr> upload() async* {
    final body = (await _dataItem.asBinary()).toBytes();
    final resp = await _bundlr.post(
      'tx/arweave',
      body: body,
      headers: {
        "Content-Type": "application/octet-stream",
      },
    );
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      _done = true;
    }
    yield this;
  }
}

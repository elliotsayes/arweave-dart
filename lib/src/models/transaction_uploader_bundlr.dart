import 'dart:async';

import 'package:arweave/arweave.dart';
import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/models/transaction_uploader_base.dart';

class TransactionUploaderBundlr extends TransactionUploader {
  final DataItem _dataItem;
  final BundlrApi _bundlr;

  @override
  bool get isComplete => throw UnimplementedError();
  @override
  int get totalChunks => throw UnimplementedError();
  @override
  int get uploadedChunks => throw UnimplementedError();
  @override
  double get progress => throw UnimplementedError();

  final int maxConcurrentChunkUploadCount;

  bool _txPosted = false;
  int _uploadedChunks = 0;

  TransactionUploaderBundlr(DataItem dataItem, BundlrApi api,
      {this.maxConcurrentChunkUploadCount = 128, bool forDataOnly = false})
      : _dataItem = dataItem,
        _bundlr = api,
        _txPosted = forDataOnly {
    throw UnimplementedError();
  }

  @override
  Stream<TransactionUploaderBundlr> upload() async* {
    throw UnimplementedError();
  }
}

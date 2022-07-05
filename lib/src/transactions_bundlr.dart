import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/models/transaction_uploader_bundlr.dart';
import 'package:arweave/src/transactions_base.dart';

import 'api/api.dart';
import 'models/models.dart';
import 'models/transaction_uploader_base.dart';

class TransactionsApiBundlr extends TransactionsApi {
  final BundlrApi _bundlr;

  TransactionsApiBundlr(ArweaveApi api, this._bundlr) : super(api);

  /// Returns an uploader than can be used to upload a transaction chunk by chunk, giving progress
  /// and the ability to resume.
  @override
  Future<TransactionUploader> getUploader(TransactionBase transaction,
      {int maxConcurrentUploadCount = 128, bool forDataOnly = false}) async {
    if (transaction is Transaction) {
      return TransactionUploaderArweave(
        transaction,
        api,
        maxConcurrentChunkUploadCount: maxConcurrentUploadCount,
        forDataOnly: forDataOnly,
      );
    } else if (transaction is DataItem) {
      return TransactionUploaderBundlr(
        transaction,
        _bundlr,
        maxConcurrentChunkUploadCount: maxConcurrentUploadCount,
        forDataOnly: forDataOnly,
      );
    } else {
      throw ArgumentError('transaction must be type Transaction or DataItem.');
    }
  }
}

import 'package:arweave/arweave.dart';
import 'package:arweave/src/api/api.dart';
import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/models/transaction_uploader_bundlr.dart';
import 'package:arweave/src/transactions.dart';

class ArweaveTransactionsApiBundlr extends ArweaveTransactionsApi {
  final BundlrApi bundlrApi;

  ArweaveTransactionsApiBundlr(
    ArweaveApi api,
    this.bundlrApi,
  ) : super(api);

  /// Returns an uploader than can be used to upload a transaction chunk by chunk, giving progress
  /// and the ability to resume.
  @override
  Future<TransactionUploader> getUploader(Transaction transaction,
          {int maxConcurrentUploadCount = 128,
          bool forDataOnly = false}) async =>
      TransactionUploaderBundlr(transaction, api, bundlrApi,
          maxConcurrentChunkUploadCount: maxConcurrentUploadCount,
          forDataOnly: forDataOnly);
}

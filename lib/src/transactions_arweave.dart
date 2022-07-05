import 'package:arweave/src/transactions_base.dart';

import 'api/api.dart';
import 'models/models.dart';
import 'models/transaction_uploader_base.dart';

class TransactionsApiArweave extends TransactionsApi {
  TransactionsApiArweave(ArweaveApi api) : super(api);

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
    } else {
      throw ArgumentError('transaction must be type Transaction.');
    }
  }
}

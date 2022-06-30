import 'package:arweave/arweave.dart';
import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/models/currency.dart';
import 'package:http/http.dart';

import '../api/api.dart';

class TransactionUploaderBundlr extends TransactionUploader {
  final BundlrApi _bundlrApi;

  TransactionUploaderBundlr(
    Transaction transaction,
    ArweaveApi api,
    this._bundlrApi, {
    maxConcurrentChunkUploadCount = 128,
    bool forDataOnly = false,
  }) : super(
          transaction,
          api,
          maxConcurrentChunkUploadCount: maxConcurrentChunkUploadCount,
          forDataOnly: forDataOnly,
        );

  @override
  Future<Response> postTx({dynamic body}) => _bundlrApi
      .post('tx/${currencyCode(transaction.signerCurrency)}', body: body);
  @override
  Future<Response> postChunk({dynamic body}) => _bundlrApi
      .post('chunk/${currencyCode(transaction.signerCurrency)}', body: body);

  String currencyCode(Currency currency) {
    return {
      Currency.ar: 'ar',
      Currency.eth: 'eth',
      Currency.matic: 'matic',
    }[currency]!;
  }
}

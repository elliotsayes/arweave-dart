import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/transactions_base.dart';
import 'package:arweave/src/transactions_bundlr.dart';

import 'api/api.dart';
import 'chunks.dart';
import 'transactions_arweave.dart';

class Arweave {
  ArweaveApi get api => _api;
  late ArweaveApi _api;

  ArweaveChunksApi get chunks => _chunks;
  late ArweaveChunksApi _chunks;

  BundlrApi? get bundlr => _bundlr;
  BundlrApi? _bundlr;

  TransactionsApi get transactions => _transactions;
  late TransactionsApi _transactions;

  Arweave({
    Uri? gatewayUrl,
    Uri? bundlrNodeUrl,
    bool useBundlr = false,
  }) {
    _api = ArweaveApi(gatewayUrl: gatewayUrl);
    _chunks = ArweaveChunksApi(api);

    if (useBundlr) {
      _bundlr = BundlrApi();
      _transactions = TransactionsApiBundlr(_api, _bundlr!);
    } else {
      _transactions = TransactionsApiArweave(api);
    }
  }
}

import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/transactions_bundlr.dart';

import 'api/api.dart';
import 'chunks.dart';
import 'transactions.dart';

class Arweave {
  ArweaveApi get api => _api;
  late ArweaveApi _api;

  ArweaveChunksApi get chunks => _chunks;
  late ArweaveChunksApi _chunks;

  BundlrApi? get bundlr => _bundlrApi;
  BundlrApi? _bundlrApi;

  ArweaveTransactionsApi get transactions => _transactions;
  late ArweaveTransactionsApi _transactions;

  Arweave({
    Uri? gatewayUrl,
    Uri? bundlrNodeUrl,
    bool useBundlr = false,
  }) {
    _api = ArweaveApi(gatewayUrl: gatewayUrl);
    _chunks = ArweaveChunksApi(api);

    if (useBundlr) {
      _bundlrApi = BundlrApi(nodeUrl: bundlrNodeUrl);
      _transactions = ArweaveTransactionsApiBundlr(_api, _bundlrApi!);
    } else {
      _transactions = ArweaveTransactionsApi(api);
    }
  }
}

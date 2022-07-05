import 'dart:convert';
import 'dart:typed_data';

import 'package:arweave/arweave.dart';
import 'package:arweave/src/bundlr/api.dart';

/// You can bundle multiple logical data transactions into one transaction using [DataBundle]s.
///
/// Read more about [DataBundle]s at [ANS-102](https://github.com/ArweaveTeam/arweave-standards/blob/master/ans/ANS-102.md).
void main() async {
  // Initialise an Bundlr API.
  final bundlr = BundlrApi();

  // Load an Arweave wallet.
  final wallet = Wallet.fromJwk(json.decode('<wallet jwk>'));

  // Create a data item and make sure to provide an appropriate `owner`.
  final dataItem = DataItem.withBlobData(
    owner: await wallet.getOwner(),
    data: utf8.encode('HELLOWORLD_TEST_STRING') as Uint8List,
  )
    ..addTag('MyTag', '0')
    ..addTag('OtherTag', 'Foo');

  await dataItem.sign(wallet);

  final body = (await dataItem.asBinary()).toBytes();
  final resp = await bundlr.post(
    'tx/arweave',
    body: body,
    headers: {"Content-Type": "application/octet-stream"},
  );

  print(resp.statusCode);
  print(resp.body);
}

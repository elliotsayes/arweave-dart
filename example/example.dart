import 'dart:convert';

import 'package:arweave/arweave.dart';

void main() async {
  // Initialise an Arweave client.
  final client = Arweave();

  // Load an Arweave wallet.
  final wallet = Wallet.fromJwk(json.decode('<wallet jwk>'));

  final owner = await wallet.getOwner();

  // Create a data transaction.
  final transaction = await client.transactions.prepare(
    Transaction.withBlobData(data: utf8.encode('Hello world!')),
    owner,
  );

  // Optionally add tags to the transaction.
  transaction
    ..addTag('App-Name', 'Hello World App')
    ..addTag('App-Version', '1.0.0');

  // Sign the transaction.
  final signatureData = await transaction.getSignatureData();
  final rawSignature = await wallet.sign(signatureData);
  await transaction.sign(rawSignature);

  // Upload the transaction in a single call:
  await client.transactions.post(transaction);

  // Or for larger data transactions, upload it progressively:
  await for (final upload in client.transactions.upload(transaction)) {
    print('${upload.progress * 100}%');
  }
}

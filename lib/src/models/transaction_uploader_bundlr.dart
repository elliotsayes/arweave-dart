import 'dart:async';
import 'dart:convert';

import 'package:arweave/arweave.dart';
import 'package:arweave/src/bundlr/api.dart';
import 'package:arweave/src/models/currency.dart';
import 'package:http/http.dart';
import 'package:retry/retry.dart';

import '../../utils.dart';
import '../api/api.dart';
import '../crypto/crypto.dart';

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
  Future<Response> postChunk({dynamic body, int? index}) => _bundlrApi.post(
          'chunks/${currencyCode(transaction.signerCurrency)}/${transaction.id}/${index!}',
          body: body,
          headers: {
            "Content-Type": "application/octet-stream",
          });

  String currencyCode(Currency currency) {
    return {
      Currency.ar: 'ar',
      Currency.eth: 'ethereum',
      Currency.matic: 'matic',
    }[currency]!;
  }

  /// Uploads the transaction in full, returning a stream of events signaling
  /// the status of the upload on every completed chunk upload.
  Stream<TransactionUploader> upload() async* {
    if (!txPosted) {
      await retry(() => _postTransactionHeader());

      yield this;

      if (isComplete) {
        return;
      }
    }

    final chunkUploadCompletionStreamController = StreamController<int>();
    int chunkIndex = 0;

    Future<void> uploadChunkAndNotifyOfCompletion(int chunkIndex) async {
      try {
        await retry(
          () => _uploadChunk(chunkIndex),
          onRetry: (exception) {
            print(
              'Retrying for chunk $chunkIndex on exception ${exception.toString()}',
            );
          },
        );

        chunkUploadCompletionStreamController.add(chunkIndex);
      } catch (err) {
        print('Chunk upload failed at $chunkIndex');
        chunkUploadCompletionStreamController.addError(err);
      }
    }

    // Initiate as many chunk uploads as we can in parallel at the start.
    chunkUploadCompletionStreamController.onListen = () {
      while (chunkIndex < totalChunks &&
          chunkIndex < maxConcurrentChunkUploadCount) {
        uploadChunkAndNotifyOfCompletion(chunkIndex);
        chunkIndex++;
      }
    };

    // Start a new chunk upload if there are still any left to upload and
    // notify the stream consumer of chunk upload completion events.
    yield* chunkUploadCompletionStreamController.stream
        .map((completedChunkIndex) {
      uploadedChunks++;

      if (chunkIndex < totalChunks) {
        uploadChunkAndNotifyOfCompletion(chunkIndex);
        chunkIndex++;
      } else if (isComplete) {
        chunkUploadCompletionStreamController.close();
      }

      return this;
    });
  }

  /// Posts the transaction header to Arweave as well as the transaction data, if it can fit in the body.
  ///
  /// Throws an [Exception] if the transaction header could not be posted.
  Future<void> _postTransactionHeader() async {
    final uploadInBody = totalChunks <= maxChunksInBody;
    final txJson = transaction.toJson();

    if (uploadInBody) {
      if (transaction.tags.contains(Tag('Bundle-Format', 'binary'))) {
        txJson['data'] = transaction.data.buffer;
      } else {
        txJson['data'] = encodeBytesToBase64(transaction.data);
      }

      final res = await postTx(body: json.encode(txJson));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        // This transaction and it's data is uploaded.
        txPosted = true;
        uploadedChunks = totalChunks;
        return;
      }
      throw Exception('Unable to upload transaction: ${res.statusCode}');
    }

    // Post the transaction with no data.
    txJson.remove('data');
    final res = await postTx(body: json.encode(txJson));

    if (!(res.statusCode >= 200 && res.statusCode < 300)) {
      throw Exception('Unable to upload transaction: ${res.statusCode}');
    }

    txPosted = true;
  }

  /// Uploads the specified chunk onto Arweave.
  ///
  /// Throws a [StateError] if the chunk being uploaded encounters a fatal error
  /// during upload and an [Exception] if a non-fatal error is encountered.
  Future<void> _uploadChunk(int chunkIndex) async {
    final chunk = transaction.getChunk(chunkIndex);

    final chunkValid = await validatePath(
        transaction.chunks!.dataRoot,
        int.parse(chunk.offset),
        0,
        int.parse(chunk.dataSize),
        decodeBase64ToBytes(chunk.dataPath));

    if (!chunkValid) {
      throw StateError('Unable to validate chunk: $chunkIndex');
    }

    final res = await postChunk(index: chunkIndex, body: json.encode(chunk));

    if (res.statusCode != 200) {
      final responseError = getResponseError(res);

      if (fatalChunkUploadErrors.contains(responseError)) {
        throw StateError(
            'Fatal error uploading chunk: $chunkIndex: ${res.statusCode} $responseError');
      } else {
        throw Exception(
            'Received non-fatal error while uploading chunk $chunkIndex: ${res.statusCode} $responseError');
      }
    }
  }
}

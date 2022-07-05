abstract class TransactionUploader {
  bool get isComplete;
  int get totalChunks;
  int get uploadedChunks;

  double get progress;

  Stream<TransactionUploader> upload();
}

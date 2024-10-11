abstract class TransactionEvent {}

class UploadFileEvent extends TransactionEvent {
  final String filePath;

  UploadFileEvent(this.filePath);
}

class CalculateTotalEvent extends TransactionEvent {
  final DateTime startTime;
  final DateTime endTime;

  CalculateTotalEvent(this.startTime, this.endTime);
}



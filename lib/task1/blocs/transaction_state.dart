// form_state.dart
abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class LoadingState extends TransactionState {} // Loading

class FileUploadedState extends TransactionState {
  final List<List<dynamic>> rows;
  final String fileName;
  FileUploadedState(this.rows, this.fileName);
}

class TotalCalculatedState extends TransactionState {
  final double totalAmount;
  final String fileName;

  TotalCalculatedState(this.totalAmount, this.fileName);
}




class ErrorState extends TransactionState {
  final String message;

  ErrorState(this.message);
}

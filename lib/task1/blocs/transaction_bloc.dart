import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:excel/excel.dart';
import '../untils/functions/binarySearchEndTime.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  List<List<dynamic>>? fileData;
  String? filePath;

  TransactionBloc() : super(TransactionInitialState()) {
    on<UploadFileEvent>(_onUploadFile);
    on<CalculateTotalEvent>(_onCalculateTotal);
  }

  Future<void> _onUploadFile(
      UploadFileEvent event, Emitter<TransactionState> emit) async {
    filePath = event.filePath;
    final file = File(filePath!);
    final bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<List<dynamic>> rows = [];
    for (var table in excel.tables.keys) {
      rows = excel.tables[table]!.rows;
    }

    fileData = rows.skip(8).toList();
    emit(FileUploadedState(rows, filePath!.split('/').last));
  }

  void _onCalculateTotal(
      CalculateTotalEvent event, Emitter<TransactionState> emit) {
    if (fileData == null || fileData!.isEmpty) return;

    double totalAmount = 0.0;

    int endIdx = binarySearchEndTime(fileData!, event.endTime);
    for (int i = endIdx; i < fileData!.length; i++) {
      var row = fileData![i];
      totalAmount += calculateRowAmount(row, event.startTime, event.endTime);
    }

    String fileName = filePath!.split('/').last;
    emit(TotalCalculatedState(totalAmount, fileName));
  }
}

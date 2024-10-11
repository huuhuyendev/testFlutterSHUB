import 'package:excel/excel.dart';
import 'package:intl/intl.dart';

int binarySearchEndTime(List<List<dynamic>> fileData, DateTime endTime) {
  int left = 0;
  int right = fileData.length - 1;

  while (left <= right) {
    int mid = (left + right) ~/ 2;
    var timeCell = fileData[mid][2];
    String timeString =
        timeCell is Data ? timeCell.value.toString() : timeCell.toString();

    if (timeString.isEmpty) continue;

    try {
      DateTime transactionTime =
          DateFormat("HH:mm:ss").parse(timeString.trim());
      transactionTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        transactionTime.hour,
        transactionTime.minute,
        transactionTime.second,
      );

      if (transactionTime.isBefore(endTime)) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    } catch (e) {
      continue;
    }
  }

  return right >= 0 ? right : 0;
}

double calculateRowAmount(
    List<dynamic> row, DateTime startTime, DateTime endTime) {
  var timeCell = row[2];
  String timeString =
      timeCell is Data ? timeCell.value.toString() : timeCell.toString();

  if (timeString.isNotEmpty) {
    try {
      DateTime transactionTime =
          DateFormat("HH:mm:ss").parse(timeString.trim());
      transactionTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        transactionTime.hour,
        transactionTime.minute,
        transactionTime.second,
      );

      if ((transactionTime.isAfter(startTime) ||
              transactionTime.isAtSameMomentAs(startTime)) &&
          (transactionTime.isBefore(endTime) ||
              transactionTime.isAtSameMomentAs(endTime))) {
        var amountCell = row[8];
        String amountString = amountCell is Data
            ? amountCell.value.toString()
            : amountCell.toString();
        amountString = amountString.replaceAll(',', '');
        return double.parse(amountString);
      }
    } catch (e) {
      //   print(e);
    }
  }
  return 0.0;
}

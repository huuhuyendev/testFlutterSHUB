import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerX extends StatelessWidget {
  final String label;
  final String? errorText;
  final bool isSubmitting;
  final String value;
  final Function(String) onChanged;

  const DateTimePickerX({
    Key? key,
    required this.label,
    required this.errorText,
    required this.isSubmitting,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (selectedDate != null) {
          final TimeOfDay? selectedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          if (selectedTime != null) {
            final DateTime fullDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            onChanged(fullDateTime.toIso8601String());
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        alignment: Alignment.centerLeft,
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value.isEmpty
                      ? 'Chọn thời gian'
                      : DateFormat('dd/MM/yyyy HH:mm')
                      .format(DateTime.parse(value)),
                  style:
                  TextStyle(color: value.isEmpty ? Colors.grey : Colors.black),
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12.0),
                    ),
                  ),
              ],
            ),
            const Icon(

              Icons.calendar_today,
              size: 20.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

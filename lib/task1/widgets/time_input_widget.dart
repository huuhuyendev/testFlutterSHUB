import 'package:flutter/material.dart';

class TimeInputWidget extends StatelessWidget {
  final String label;
  final Function(String) onChanged;

  const TimeInputWidget({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FB),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      onChanged: onChanged,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TextFieldX extends StatelessWidget {
  final String label;
  final String? errorText;
  final bool isSubmitting;
  final Function(String) onChanged;
  final Icon? suffixIcon;

  const TextFieldX({
    super.key,
    required this.label,
    required this.errorText,
    required this.isSubmitting,
    required this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      alignment: Alignment.centerLeft,
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                TextField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: '0.0',
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                    border: InputBorder.none,
                    errorText: errorText,
                  ),
                ),
              ],
            ),
          ),
          if (suffixIcon != null) // Hiển thị biểu tượng nếu có
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: suffixIcon,
            ),
        ],
      ),
    );
  }
}



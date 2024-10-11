import 'package:flutter/material.dart';

class DropdownX extends StatelessWidget {
  final String label;
  final String? errorText;
  final bool isSubmitting;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const DropdownX({
    Key? key,
    required this.label,
    required this.errorText,
    required this.isSubmitting,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

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
          DropdownButtonFormField<String>(
            value: value,
            onChanged: (String? newValue) {
              onChanged(newValue);
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(0),
              border: InputBorder.none,
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }
}

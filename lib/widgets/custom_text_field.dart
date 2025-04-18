import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? errorText;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}
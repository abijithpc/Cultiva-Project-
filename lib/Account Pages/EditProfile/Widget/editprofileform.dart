import 'package:flutter/material.dart';

class EditFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget prefixIcon;

  const EditFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$labelText is required";
        }
        return null;
      },
    );
  }
}
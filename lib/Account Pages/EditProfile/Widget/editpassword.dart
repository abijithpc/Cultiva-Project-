import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isSecurePassword;
  final VoidCallback onToggle;

  const PasswordField({
    super.key,
    required this.controller,
    required this.isSecurePassword,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isSecurePassword,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            isSecurePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        return null;
      },
    );
  }
}
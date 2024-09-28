import 'package:flutter/material.dart';

class Buildpassword extends StatelessWidget {
  final TextEditingController controller;
  final bool isSecurePassword;
  final VoidCallback togglepasswordVisibility;
  final String? Function(String?)? validator;

  const Buildpassword({
    super.key,
    required this.controller,
    required this.isSecurePassword,
    required this.togglepasswordVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isSecurePassword,
      decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(Icons.password),
          suffixIcon: IconButton(
              onPressed: togglepasswordVisibility,
              icon: isSecurePassword
                  ? const Icon(Icons.visibility)
                  : Icon(Icons.visibility_off)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          border: const OutlineInputBorder()),
      validator: (value) =>
          value == null || value.isEmpty ? "Password Field is Required" : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onSave;

  const SaveButton({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSave,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 23, 65, 24),
        minimumSize: const Size(300, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        "Save",
        style: GoogleFonts.judson(
          textStyle: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
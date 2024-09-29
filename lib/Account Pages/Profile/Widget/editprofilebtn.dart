import 'package:cultiva/Account%20Pages/EditProfile/editprofile.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileBtn extends StatelessWidget {
  const EditProfileBtn({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Editprofile(
                      user: _user,
                    )));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 202, 197, 51),
          minimumSize: Size(160, 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Text(
        "Edit Profile",
        style: GoogleFonts.judson(
            textStyle: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}

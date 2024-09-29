import 'package:cultiva/Account%20Pages/Profile/Widget/editprofilebtn.dart';
import 'package:cultiva/Screens/loginhomescreens.dart/loginhomescreen.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUserDetails extends StatelessWidget {
  const ProfileUserDetails({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditProfileBtn(user: _user),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Text(
              _user.username,
              style: GoogleFonts.judson(
                  textStyle:
                      TextStyle(color: Colors.black, fontSize: 25)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              _user.phonenumber.toString(),
              style: GoogleFonts.judson(
                  textStyle: TextStyle(
                      color: const Color.fromARGB(255, 11, 11, 11),
                      fontSize: 19)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              _user.email,
              style: GoogleFonts.judson(
                  textStyle: TextStyle(
                      color: const Color.fromARGB(255, 11, 11, 11),
                      fontSize: 18)),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Loginhomescreen()));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 65, 24),
              minimumSize: Size(300, 60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            "Log Out",
            style: GoogleFonts.judson(
                textStyle: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        )
      ],
    );
  }
}
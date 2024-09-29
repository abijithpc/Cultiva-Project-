import 'dart:io';

import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileImageAndGreeting extends StatelessWidget {
  const ProfileImageAndGreeting({
    super.key,
    required this.screenheigth,
    required this.screenWidth,
    required User user,
  }) : _user = user;

  final double screenheigth;
  final double screenWidth;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 174, 236, 177),
      height: screenheigth * .40,
      width: screenWidth * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Hello ${_user.username}...',
              style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 30)),
            ),
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 75,
              backgroundImage: _user.profileImage != null
                  ? FileImage(File(_user.profileImage!))
                  : AssetImage('Assets/profile.png') as ImageProvider,
            )
          ],
        ),
      ),
    );
  }
}
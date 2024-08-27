import 'dart:io';

import 'package:cultiva/Account%20Pages/editProfile.dart';
import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:cultiva/function/profile/profile.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = await fetchDetails();

    if (user != null) {
      setState(() {
        _user = user;

        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 174, 236, 177),
          title: Text(
            "Profile",
            style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 30)),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 174, 236, 177),
        title: Text(
          "Profile",
          style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 30)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 174, 236, 177),
            height: screenheigth * .40,
            width: screenWidth * 1,
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
          Column(
            children: [
              ElevatedButton(
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  "Edit Profile",
                  style: GoogleFonts.judson(
                      textStyle: TextStyle(color: Colors.white, fontSize: 24)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                _user.username,
                style: GoogleFonts.judson(
                    textStyle: TextStyle(color: Colors.black, fontSize: 25)),
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
          )
        ],
      ),
    );
  }
}

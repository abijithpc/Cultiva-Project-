import 'package:cultiva/Account%20Pages/Profile/Widget/profileimageandgreeting.dart';
import 'package:cultiva/Account%20Pages/Profile/Widget/profileusersection.dart';
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
          ProfileImageAndGreeting(
              screenheigth: screenheigth,
              screenWidth: screenWidth,
              user: _user),
          ProfileUserDetails(user: _user)
        ],
      ),
    );
  }
}

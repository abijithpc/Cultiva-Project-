import 'package:cultiva/Account%20Pages/addnewproduct.dart';
import 'package:cultiva/Account%20Pages/privacy&policy.dart';
import 'package:cultiva/Account%20Pages/productselled.dart';
import 'package:cultiva/Account%20Pages/profile.dart';
import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Accountpages extends StatefulWidget {
  const Accountpages({super.key});

  @override
  State<Accountpages> createState() => _AccountpagesState();
}

class _AccountpagesState extends State<Accountpages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 27, fontWeight: FontWeight.w600)),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.addressBook),
                  title: Text(
                    "Account Details",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600)),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Privacy()));
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.shieldHalved),
                  title: Text(
                    "Privacy & Policies",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addnewproduct()));
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.cartPlus),
                  title: Text(
                    "Add Products",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Productselled()));
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.tag),
                  title: Text(
                    "Sold Details",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidClipboard),
                  title: Text(
                    "Overview",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Loginhomescreen()));
                },
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

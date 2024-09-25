// accountpages.dart
import 'package:cultiva/Account%20Pages/about_us.dart';
import 'package:cultiva/Account%20Pages/addnewproduct.dart';
import 'package:cultiva/Account%20Pages/outofstock.dart';
import 'package:cultiva/Account%20Pages/privacy_policy.dart';
import 'package:cultiva/Account%20Pages/profile.dart';
import 'package:cultiva/Account%20Pages/terms_condition.dart';
import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:cultiva/widget/accountcard.dart';
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
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: GoogleFonts.judson(
            textStyle:
                const TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: screenheigth,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AccountCard(
                  icon: FontAwesomeIcons.addressBook,
                  title: 'Account Details',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                ),
                AccountCard(
                  icon: FontAwesomeIcons.shieldHalved,
                  title: 'Privacy & Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Privacy()),
                    );
                  },
                ),
                AccountCard(
                  icon: FontAwesomeIcons.cartPlus,
                  title: 'Add Products',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Addnewproduct(categories: const [])),
                    );
                  },
                ),
                AccountCard(
                  icon: FontAwesomeIcons.ban,
                  title: 'Stock Out Items',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Outofstock()),
                    );
                  },
                ),
                AccountCard(
                  icon: FontAwesomeIcons.fileContract,
                  title: 'Terms & Condition',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Termcondition()),
                    );
                  },
                ),
                AccountCard(
                  icon: FontAwesomeIcons.circleInfo,
                  title: 'About Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUs()),
                    );
                  },
                ),
                AccountCard(
                  icon: FontAwesomeIcons.arrowRightFromBracket,
                  iconColor: Colors.red,
                  title: 'Log Out',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Loginhomescreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

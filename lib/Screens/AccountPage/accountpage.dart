import 'package:cultiva/Account%20Pages/addnewproduct.dart';
import 'package:cultiva/Account%20Pages/OutofStock/outofstock.dart';
import 'package:cultiva/Account%20Pages/PrivacyAndPolicy/privacy_policy.dart';
import 'package:cultiva/Account%20Pages/Profile/profile.dart';
import 'package:cultiva/Account%20Pages/TermsAndCondition/terms_condition.dart';
import 'package:cultiva/Screens/AccountPage/Widget/accountcard.dart';
import 'package:cultiva/Screens/loginhomescreens.dart/loginhomescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Accountpages extends StatefulWidget {
  const Accountpages({super.key});

  @override
  State<Accountpages> createState() => _AccountpagesState();
}

class _AccountpagesState extends State<Accountpages> {
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchAppVersion();
  }

  // Fetch app version using package_info_plus
  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${packageInfo.version}'; // App version
    });
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                              builder: (context) =>
                                  Addnewproduct(categories: const [])),
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
                          MaterialPageRoute(
                              builder: (context) => Termcondition()),
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
                // Display app version at the bottom
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "App Version: $_appVersion",
                        style: GoogleFonts.judson(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
              _buildcards(
                icon: FontAwesomeIcons.addressBook,
                title: 'AccountDetails',
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              _buildcards(
                icon: FontAwesomeIcons.shieldHalved,
                title: 'Privacy & Policy',
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Privacy()));
                },
              ),
              _buildcards(
                icon: FontAwesomeIcons.cartPlus,
                title: 'Add Products',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Addnewproduct(categories: [])));
                },
              ),
              _buildcards(
                icon: FontAwesomeIcons.tag,
                title: 'Sold Products',
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Productselled()));
                },
              ),
              const Spacer(),
              _buildcards(
                icon: FontAwesomeIcons.arrowRightFromBracket,
                iconColor: Colors.red,
                title: 'Log Out',
                ontap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Loginhomescreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildcards(
      {required IconData icon,
      required String title,
      required Function() ontap,
      Color iconColor = Colors.black}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ]),
        child: ListTile(
          leading: FaIcon(
            icon,
            size: 28,
            color: iconColor,
          ),
          title: Text(
            title,
            style: GoogleFonts.judson(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

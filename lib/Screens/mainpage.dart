import 'package:cultiva/Screens/accountpage.dart';
import 'package:cultiva/Screens/cartpage.dart';
import 'package:cultiva/Screens/homepage.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mainpage extends StatefulWidget {
  final Sellinfo? sellinfo;
  final Product? selectedProduct;
  const Mainpage(
      {super.key, required this.sellinfo, required this.selectedProduct});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;

  void bottomnavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [Homepage(), Cartpage(), Accountpages()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 12, 62, 20),
        buttonBackgroundColor: const Color.fromARGB(255, 12, 62, 20),
        height: 60,
        index: _selectedIndex,
        onTap: bottomnavBar,
        items: <Widget>[
          FaIcon(FontAwesomeIcons.house, size: 20, color: Colors.white),
          FaIcon(FontAwesomeIcons.cartShopping, size: 20, color: Colors.white),
          FaIcon(FontAwesomeIcons.solidUser, size: 20, color: Colors.white),
        ],
      ),
    );
  }
}

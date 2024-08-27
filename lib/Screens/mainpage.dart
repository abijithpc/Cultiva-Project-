import 'package:cultiva/Screens/accountpage.dart';
import 'package:cultiva/Screens/cartpage.dart';
import 'package:cultiva/Screens/homepage.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.only(top: 10),
        child: SizedBox(
          height: 100,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 56, 150, 72),
            unselectedItemColor: Colors.black,
            onTap: bottomnavBar,
            items: [
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    size: 20,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.cartShopping,
                    size: 20,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 20,
                  ),
                  label: "")
            ],
          ),
        ),
      ),
    );
  }
}

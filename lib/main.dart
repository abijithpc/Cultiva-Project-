import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:cultiva/Screens/mainpage.dart';
import 'package:cultiva/model/cartdata.dart';
import 'package:cultiva/model/model.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<User> userBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //User Adaptor
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('userBox');

  //Product Adaptor
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('ProductBox');

  //sell details
  Hive.registerAdapter(SellinfoAdapter());
  await Hive.openBox<Sellinfo>('sellBox');

  // cartdata
  Hive.registerAdapter(CartdataAdapter());
  await Hive.openBox<Cartdata>('cartBox');

  final authBox = await Hive.openBox('authBox');

  bool isLoggedIn = authBox.get('isLoggedIn', defaultValue: false);

  userBox = await Hive.openBox<User>('users');
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? Mainpage(
              selectedProduct: null,
              sellinfo: null,
            )
          : Loginhomescreen(),
    );
  }
}

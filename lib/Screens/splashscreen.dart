import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        // width: ScreenWidth * 1,
        height: Screenheigth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://unsplash.com/photos/forest-during-daytime-wQImoykAwGs'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}

import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:cultiva/Screens/mainpage.dart';
import 'package:cultiva/Screens/signup.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController usernamecntrlr = TextEditingController();
  final TextEditingController passwordcntrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Loginhomescreen()));
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        height: Screenheigth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'Assets/Backgroundimage/raihan-n-aziz-vXqYyGs3_Pc-unsplash.jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Text(
                    "Login Now",
                    style: GoogleFonts.judson(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 5,
                            color: Color.fromARGB(
                              255,
                              104,
                              98,
                              98,
                            ),
                            fontSize: 40)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: ScreenWidth * 0.85,
                          child: TextFormField(
                            controller: usernamecntrlr,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.3),
                                border: OutlineInputBorder(),
                                hintText: "Username"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Screenheigth * .03,
                        ),
                        SizedBox(
                          width: ScreenWidth * 0.85,
                          child: TextFormField(
                            controller: passwordcntrlr,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.3),
                                border: OutlineInputBorder(),
                                hintText: "Password"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Screenheigth * .08,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              checklogin();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("Please enter All Field")));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 23, 65, 24),
                              minimumSize: Size(300, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "Log In",
                            style: GoogleFonts.judson(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Don't Have an Account",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 177, 175, 175),
                              fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 177, 175, 175),
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checklogin() async {
    final userBox = Hive.box<User>('userBox');
    final users = userBox.values;

    final username = usernamecntrlr.text;
    final passwords = passwordcntrlr.text;

    bool founduser = false;

    for (var user in users) {
      if (user.username == username && user.password == passwords) {
        founduser = true;

        final authBox = await Hive.openBox('authBox');
        await authBox.put(
            'currentUserIndex', userBox.keys.toList().indexOf(user.key));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const Mainpage(
                      sellinfo: null,
                      selectedProduct: null,
                    )),
            (route) => false);
        break;
      }
    }
    if (!founduser) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Incorrect Password or Username",
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
  }

}

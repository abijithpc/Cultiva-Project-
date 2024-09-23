import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:cultiva/Screens/signup.dart';
import 'package:cultiva/function/loginpage/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool isLoginPassword = true;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController usernamecntrlr = TextEditingController();
  final TextEditingController passwordcntrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 90, 22),
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
        height: screenheigth,
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
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.judson(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 40)),
                      ),
                      Text(
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
                                fontSize: 25)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.85,
                          child: TextFormField(
                            controller: usernamecntrlr,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.3),
                                border: OutlineInputBorder(),
                                labelText: "Username"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenheigth * .03,
                        ),
                        SizedBox(
                          width: screenWidth * 0.85,
                          child: TextFormField(
                            controller: passwordcntrlr,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: isLoginPassword,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: tooglePassword(),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.3),
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenheigth * .08,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              checklogin(
                                  context, usernamecntrlr, passwordcntrlr);
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

  Widget tooglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            isLoginPassword = !isLoginPassword;
          });
        },
        icon: isLoginPassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }
}

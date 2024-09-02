// ignore_for_file: prefer_const_constructors

import 'package:cultiva/Screens/loginhomescreen.dart';
import 'package:cultiva/function/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isSignUpPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'Assets/Backgroundimage/raihan-n-aziz-vXqYyGs3_Pc-unsplash.jpg'),
                fit: BoxFit.cover)),
        height: screenheigth * 1,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        "Sign Up",
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          labelText: "Username",
                          border: OutlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty
                          ? "Username field is required"
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          labelText: "Email",
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field is required';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'please enter valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: TextFormField(
                      controller: numbercontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          labelText: "Phone Number",
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'number field is required';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter Valid 10 digit Number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenWidth * 0.85,
                    child: TextFormField(
                      obscureText: isSignUpPassword,
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: tooglePassword(),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          labelText: " Password",
                          border: OutlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty
                          ? "Password Field is Required"
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //dismiss the keyboard
                      FocusScope.of(context).unfocus();
                      SignupHelper().saveData(
                          context,
                          nameController,
                          emailController,
                          passwordController,
                          numbercontroller,
                          _formKey);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 23, 65, 24),
                        minimumSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.judson(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 24)),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget tooglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            isSignUpPassword = !isSignUpPassword;
          });
        },
        icon: isSignUpPassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }
}

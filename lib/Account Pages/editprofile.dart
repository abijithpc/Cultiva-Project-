import 'dart:io';

import 'package:cultiva/function/saveprofile/saveprofile.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  final User user;

  const Editprofile({super.key, required this.user});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool isSecurePassword = true;
  late TextEditingController editusername;
  late TextEditingController editphonenumber;
  late TextEditingController editemail;
  late TextEditingController editpassword;
  File? _image;

  @override
  void initState() {
    super.initState();

    editusername = TextEditingController(text: widget.user.username);
    editphonenumber =
        TextEditingController(text: widget.user.phonenumber.toString());
    editemail = TextEditingController(text: widget.user.email);
    editpassword = TextEditingController(text: widget.user.password);
    if (widget.user.profileImage != null) {
      _image = File(widget.user.profileImage!);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 26)),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenheigth,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Form(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : AssetImage('Assets/profile.png') as ImageProvider,
                      child: _image == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: editusername,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Username",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: const OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Password Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenheigth * .02,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: editphonenumber,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: Icon(Icons.phone),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: const OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Phonenumber Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenheigth * .02,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: editemail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              labelText: "Email Address",
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Email Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenheigth * .02,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: editpassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: isSecurePassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: tooglePassword(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: const OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Password Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenheigth * .02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      saveProfile(widget.user, editusername, editphonenumber,
                          editemail, editpassword, _image, context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 23, 65, 24),
                        minimumSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Save",
                      style: GoogleFonts.judson(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 24)),
                    ),
                  ),
                ],
              ),
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
            isSecurePassword = !isSecurePassword;
          });
        },
        icon: isSecurePassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }
}

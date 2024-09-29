import 'dart:io';

import 'package:cultiva/Account%20Pages/EditProfile/Widget/editpassword.dart';
import 'package:cultiva/Account%20Pages/EditProfile/Widget/editpicturesection.dart';
import 'package:cultiva/Account%20Pages/EditProfile/Widget/editprofilebtn.dart';
import 'package:cultiva/Account%20Pages/EditProfile/Widget/editprofileform.dart';
import 'package:cultiva/function/saveprofile/saveprofile.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Form(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  EditpictureSection(
                    image: _image,
                    onImagePicked: (newImage) {
                      setState(() {
                        _image = newImage;
                        imageCache.clear();
                        imageCache.clearLiveImages();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  EditFormField(
                    controller: editusername,
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),
                  EditFormField(
                    controller: editphonenumber,
                    labelText: "PhoneNumber",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  const SizedBox(height: 20),
                  EditFormField(
                    controller: editemail,
                    labelText: "Email Id",
                    prefixIcon: Icon(Icons.email),
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: editpassword,
                    isSecurePassword: isSecurePassword,
                    onToggle: () {
                      setState(() {
                        isSecurePassword = !isSecurePassword;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SaveButton(
                    onSave: () {
                      saveProfile(
                        widget.user,
                        editusername,
                        editphonenumber,
                        editemail,
                        editpassword,
                        _image,
                        context,
                      );
                      if (_image != null) {
                        widget.user.profileImage = _image!.path;
                      }
                      Navigator.pop(context, widget.user);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cultiva/Account%20Pages/EditProfile/Widget/editpassword.dart';
import 'package:cultiva/Account%20Pages/EditProfile/Widget/editpicturesection.dart';
import 'package:cultiva/Account%20Pages/EditProfile/Widget/editprofilebtn.dart';
import 'package:cultiva/Account%20Pages/EditProfile/Widget/editprofileform.dart';
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
                  EditpictureSection(image: _image),
                  const SizedBox(
                    height: 20,
                  ),
                  EditFormField(
                      controller: editusername,
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person)),
                  SizedBox(
                    height: 20,
                  ),
                  EditFormField(
                      controller: editphonenumber,
                      labelText: "PhoneNumber",
                      prefixIcon: Icon(Icons.phone)),
                  SizedBox(
                    height: 20,
                  ),
                  EditFormField(
                      controller: editemail,
                      labelText: "Email Id",
                      prefixIcon: Icon(Icons.email)),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordField(
                    controller: editpassword,
                    isSecurePassword: isSecurePassword,
                    onToggle: () {
                      setState(() {
                        isSecurePassword = !isSecurePassword;
                      });
                    },
                  ),
                  SizedBox(
                    height: screenheigth * .02,
                  ),
                  SaveButton(
                    onSave: () {
                      setState(() {
                        saveProfile(
                          widget.user,
                          editusername,
                          editphonenumber,
                          editemail,
                          editpassword,
                          _image,
                          context,
                        );
                      });
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

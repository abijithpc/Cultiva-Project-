import 'dart:io';

import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  final User user;

  const Editprofile({super.key, required this.user});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
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
        TextEditingController(text: widget.user.Phonenumber.toString());
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

  void saveProfile() async {
    final box = await Hive.openBox<User>('UserBox');
    final index = box.values.toList().indexOf(widget.user);

    if (index != -1) {
      User updatedUser = widget.user
        ..username = editusername.text
        ..Phonenumber = int.tryParse(editphonenumber.text) ?? 0
        ..email = editemail.text
        ..password = editpassword.text
        ..profileImage = _image?.path;

      await box.putAt(index, updatedUser);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 26)),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: ScreenWidth,
        height: Screenheigth,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Form(
            child: SingleChildScrollView(
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
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                          ),
                        ],
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: editusername,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Password Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screenheigth * .02,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "PhoneNumber",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: editphonenumber,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Phonenumber Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screenheigth * .02,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "EmailAddress",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: editemail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
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
                    height: Screenheigth * .02,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: editpassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? "Password Field is Required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screenheigth * .02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      saveProfile();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 23, 65, 24),
                        minimumSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Save",
                      style: GoogleFonts.judson(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 24)),
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
}

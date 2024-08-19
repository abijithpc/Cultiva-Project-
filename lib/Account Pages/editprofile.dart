import 'dart:io';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController editusername = TextEditingController();
  TextEditingController editphonenumber = TextEditingController();
  TextEditingController editemail = TextEditingController();
  TextEditingController editpassword = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    var box = Hive.box<User>('Userbox');
    User? users = box.get(0);

    if (users != null) {
      editusername.text = users.username;
      editphonenumber.text = users.Phonenumber.toString();
      editemail.text = users.email;
      editpassword.text = users.password;
      if (users.profileImage != null) {
        _image = File(users.profileImage!);
      }
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
    var box = await Hive.openBox<User>('UserBox');

    int UserKey = 0;
    User? user = box.get(0);

    if (user != null) {
      user.username = editusername.text;
      user.Phonenumber = int.tryParse(editphonenumber.text) ?? 0;
      user.email = editemail.text;
      user.password = editpassword.text;
      user.profileImage = _image?.path;

      await user.save();

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

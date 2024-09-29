import 'package:cultiva/Screens/Signup/Widget/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:cultiva/function/signup.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isSignUpPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextFormField(
            controller: nameController,
            icon: Icons.person,
            labelText: 'Username',
            validator: (value) => value == null || value.isEmpty ? 'Username field is required' : null,
            screenWidth: screenWidth,
          ),
          SizedBox(height: 20),
          buildTextFormField(
            controller: emailController,
            icon: Icons.email,
            labelText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email field is required';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            screenWidth: screenWidth,
          ),
          SizedBox(height: 20),
          buildTextFormField(
            controller: numberController,
            icon: Icons.phone,
            labelText: 'Phone Number',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Number field is required';
              } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Please enter a valid 10 digit number';
              }
              return null;
            },
            screenWidth: screenWidth,
          ),
          SizedBox(height: 20),
          buildPasswordField(screenWidth),
          SizedBox(height: 20),
          SignupButton(
            onPressed: () {
              // Dismiss the keyboard
              FocusScope.of(context).unfocus();
              
              // Call the saveData function with form key validation
              SignupHelper().saveData(
                context,
                nameController,
                emailController,
                passwordController,
                numberController,
                _formKey,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
    required FormFieldValidator<String> validator,
    double? screenWidth,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      width: screenWidth! * 0.85,
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  Widget buildPasswordField(double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.85,
      child: TextFormField(
        obscureText: isSignUpPassword,
        controller: passwordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isSignUpPassword = !isSignUpPassword;
              });
            },
            icon: isSignUpPassword
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          labelText: "Password",
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Password Field is Required' : null,
      ),
    );
  }
}

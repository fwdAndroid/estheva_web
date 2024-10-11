import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:estheva_web/screens/auth/login_screen.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/services/auth_methods.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/image_utils.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  bool isChecked = false;
  bool passwordVisible = false;
  //Image
  Uint8List? _image;
  //loader
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: mainColor,
        title: Text(
          "Create Account",
          style: TextStyle(
            color: white,
            fontFamily: 'Futura',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 30,
            ),
            // GestureDetector(
            //   onTap: () => selectImage(),
            //   child: Stack(
            //     children: [
            //       _image != null
            //           ? CircleAvatar(
            //               radius: 59, backgroundImage: MemoryImage(_image!))
            //           : GestureDetector(
            //               onTap: () => selectImage(),
            //               child: CircleAvatar(
            //                 radius: 59,
            //                 backgroundImage: AssetImage('assets/person.png'),
            //               ),
            //             ),
            //     ],
            //   ),
            // ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontFamily: 'Futura',
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _nameController,
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Futura',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Enter Full Name",
                        hintStyle: TextStyle(
                            fontFamily: 'Futura', color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontFamily: 'Futura',
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Futura',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Create Email ",
                        hintStyle: TextStyle(
                            fontFamily: 'Futura', color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontFamily: 'Futura',
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    obscureText: passwordVisible,
                    controller: _passwordController,
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Futura',
                    ),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Create Password",
                        hintStyle: TextStyle(
                            fontFamily: 'Futura', color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Contact Number',
                      style: TextStyle(
                          fontFamily: 'Futura',
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Futura',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Contact Number ",
                        hintStyle: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontFamily: 'Futura',
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : SaveButton(
                      title: "Sign Up",
                      onTap: () async {
                        if (_nameController.text.isEmpty) {
                          showMessageBar(
                              "Name of the user is required", context);
                        } else if (_emailController.text.isEmpty) {
                          showMessageBar("Email is required", context);
                        } else if (_passwordController.text.isEmpty) {
                          showMessageBar("Password is required ", context);
                        } else if (_contactController.text.isEmpty) {
                          showMessageBar(
                              "Contact Number is required ", context);
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthMethods().signUpUser(
                            isblocked: false,
                            email: _emailController.text.trim(),
                            pass: _passwordController.text.trim(),
                            username: _nameController.text.trim(),
                            contact: _contactController.text.trim(),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          showMessageBar("Registration Complete", context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => MainDashboard(
                                        type: 'clinic',
                                      )));
                        }
                      },
                    ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(TextSpan(
                    text: 'Already have an account? ',
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                            fontFamily: 'Futura',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      )
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Functions
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}

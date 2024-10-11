import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/screens/auth/login_screen.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController providerPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Forgot password,",
              style: TextStyle(
                  fontFamily: 'Futura',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please type your email below and we will give you a OTP code,",
              style: TextStyle(
                fontFamily: 'Futura',
                fontSize: 14,
              ),
            ),
          ),
          Flexible(child: Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: providerPassController,
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
                    color: black,
                    fontSize: 12,
                    fontFamily: 'Futura',
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaveButton(
                title: "Send",
                onTap: () async {
                  if (providerPassController.text.isEmpty) {
                    showMessageBar("Email is Required", context);
                  } else {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: providerPassController.text.trim())
                        .then((value) => {
                              FirebaseAuth.instance.signOut(),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => LoginScreen()))
                            });
                    showMessageBar("Email verification link is sent", context);
                  }
                }),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}

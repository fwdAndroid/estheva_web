import 'package:flutter/material.dart';
import 'package:estheva_web/screens/auth/signup_screen.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/services/auth_methods.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;
  bool passwordVisible = false;
  bool isLoading = false;
  bool isGoogle = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/newlogo.png",
              height: 104,
              width: 104,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Text("Hello Again!",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 24,
                        color: black,
                        fontWeight: FontWeight.bold)),
                Text(
                  "Welcome back you’ve been missed!",
                  style: TextStyle(
                      fontFamily: 'Futura',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text('Email',
                        style: TextStyle(
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w700,
                            color: black)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Futura',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Enter Email Address",
                        hintStyle: TextStyle(
                            fontFamily: 'Futura',
                            fontSize: 12,
                            color: black,
                            fontWeight: FontWeight.w300)),
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
                    style: TextStyle(color: black),
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
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                            fontFamily: 'Futura', color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontFamily: 'Futura',
                        ),
                      ))
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SaveButton(
                        title: "Login",
                        onTap: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            showMessageBar(
                                "Email and Password is Required", context);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            await AuthMethods().loginUpUser(
                              email: _emailController.text.trim(),
                              pass: _passwordController.text.trim(),
                            );

                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MainDashboard(
                                          type: "clinic",
                                        )));
                          }
                        }),
                  ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SignupScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(TextSpan(
                    text: 'Don’t have an account? ',
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Sign Up',
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
}

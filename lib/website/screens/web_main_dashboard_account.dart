import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/account_pages/web_edit_profile.dart';
import 'package:estheva_web/website/web_auth/web_forgot_password.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:estheva_web/widgets/logout_web_widget.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebMainDashboardAccount extends StatefulWidget {
  const WebMainDashboardAccount({super.key});

  @override
  State<WebMainDashboardAccount> createState() =>
      _WebMainDashboardAccountState();
}

class _WebMainDashboardAccountState extends State<WebMainDashboardAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isGoogleSignIn =>
      _auth.currentUser?.providerData[0].providerId == 'google.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  }
                  var snap = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          snap['fullName'],
                          style: TextStyle(
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                        Text(
                          snap['email'],
                          style: TextStyle(
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (builder) => AppointmentHistory()));
                    },
                    leading: Icon(
                      Icons.post_add,
                      color: appColor,
                    ),
                    title: Text(
                      "Appointment History",
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: appColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => WebEditProfile()));
                    },
                    leading: Icon(
                      Icons.edit,
                      color: appColor,
                    ),
                    title: Text(
                      "Edit Profile",
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: appColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  if (!isGoogleSignIn)
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => WebForgotPassword()));
                      },
                      leading: Icon(
                        Icons.language_outlined,
                        color: appColor,
                      ),
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                  if (!isGoogleSignIn)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                  ListTile(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (builder) => Payment()));
                    },
                    leading: Icon(
                      Icons.payment,
                      color: appColor,
                    ),
                    title: Text(
                      "Payment Method",
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: appColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      shareInviteLink(context);
                    },
                    leading: Icon(
                      Icons.group,
                      color: appColor,
                    ),
                    title: Text(
                      "Invite Friends",
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: appColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                  title: "Logout",
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return LogoutWebWidget();
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void shareInviteLink(BuildContext context) {
    // Replace 'YOUR_INVITE_LINK' with your actual invite link
    final String inviteLink = 'https://yourapp.com/invite?ref=friend123';
  }
}

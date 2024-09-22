import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/main_dashboard_we.dart';
import 'package:estheva_web/website/screens/web_dashboard_doctors.dart';
import 'package:estheva_web/website/screens/web_main_dashboard_account.dart';
import 'package:estheva_web/website/web_auth/web_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: mainColor,
      elevation: 0,
      title: Row(
        children: [
          // Logo
          Row(
            children: [
              Image.asset(
                "assets/logos.png", // Replace with your logo URL
                height: 40,
              ),
              Text(
                "Medicare",
                style: GoogleFonts.inter(color: white),
              )
            ],
          ),
          SizedBox(width: 20),
          // Menu items
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuItem('Home', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MainDashboardWeb(
                                type: "clinic",
                              )));
                }),
                _buildMenuItem('Appointments', () {}),
                _buildMenuItem('Doctors', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => WebDashboardDoctors()));
                }),
                _buildMenuItem('Account', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => WebMainDashboardAccount()));
                }),

                TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then((_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => WebSignInPage()));
                      });
                    },
                    child: Text(
                      "Logout",
                      style: GoogleFonts.inter(color: white),
                    )),
                // Buttons
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          title,
          style: TextStyle(color: white, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

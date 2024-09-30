import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/appointment_web/appointment_page_web.dart';
import 'package:estheva_web/website/screens/home_services/Iv_thearapy_home.dart';
import 'package:estheva_web/website/screens/home_services/body_coutouring_page_home.dart';
import 'package:estheva_web/website/screens/home_services/healthcheckup_home.dart';
import 'package:estheva_web/website/screens/home_services/iv_therapy_packages.dart';
import 'package:estheva_web/website/screens/home_services/physiotherapy_home.dart';
import 'package:estheva_web/website/screens/main_dashboard_we.dart';
import 'package:estheva_web/website/screens/web_dashboard_doctors.dart';
import 'package:estheva_web/website/screens/web_main_dashboard_account.dart';
import 'package:estheva_web/website/web_auth/web_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HeaderBarState createState() => _HeaderBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _HeaderBarState extends State<HeaderBar> {
  bool isHomeServicesExpanded = false; // State to track expansion

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: mainColor,
      elevation: 0,
      title: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => MainDashboardWeb()));
            },
            child: Row(
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
          ),
          SizedBox(width: 20),
          // Menu items
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home Services with dropdown submenus
                _buildHomeServicesMenu(),

                _buildMenuItem('Appointments', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => AppointmentPageWeb()));
                }),

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

  Widget _buildHomeServicesMenu() {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        // Handle submenu item selection with navigation
        if (result == 'Body Contouring at Home') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BodyContouringPageHome())); // Replace with the actual page for Body Contouring
        } else if (result == 'IV Drips Therapy at Home') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      IvThearapyHome())); // Replace with the actual page for IV Drips Therapy
        } else if (result == 'IV Drips Therapy Packages') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      IVDripsTherapyPackages())); // Replace with the actual page for Physiotherapy
        } else if (result == 'Health Tests at Home') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HealthCheckUpHome())); // Replace with the actual page for Health Tests
        } else if (result == 'Physiotherapy') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PhysiotherapyHome())); // Replace with the actual page for Physiotherapy
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Body Contouring at Home',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BodyContouringPageHome()));
            },
            child: Text('Body Contouring at Home'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'IV Drips Therapy at Home',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IvThearapyHome())); // Navigate to IV Drips Therapy
            },
            child: Text('IV Drips Therapy at Home'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'IV Drips Therapy Packages',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IVDripsTherapyPackages())); // Navigate to Physiotherapy
            },
            child: Text('IV Drips Therapy Packages'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Health Tests at Home',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HealthCheckUpHome())); // Navigate to Health Tests
            },
            child: Text('Health Tests at Home'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Physiotherapy',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PhysiotherapyHome())); // Navigate to Physiotherapy
            },
            child: Text('Physiotherapy Test at Home'),
          ),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Home',
              style: TextStyle(color: white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

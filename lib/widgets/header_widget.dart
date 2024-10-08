import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/appointment_web/appointment_page_web.dart';
import 'package:estheva_web/website/screens/clinic_services/aestheticatclince.dart';
import 'package:estheva_web/website/screens/clinic_services/bodu_contouring_page_clinic.dart';
import 'package:estheva_web/website/screens/clinic_services/hair_transplant.dart';
import 'package:estheva_web/website/screens/clinic_services/health_checkup_clinic.dart';
import 'package:estheva_web/website/screens/clinic_services/iv_drips_therapy_clinic.dart';
import 'package:estheva_web/website/screens/clinic_services/iv_drips_therapy_pacakages_clinic.dart';
import 'package:estheva_web/website/screens/clinic_services/physiotherapy_at_clinic.dart';
import 'package:estheva_web/website/screens/home_services/Iv_thearapy_home.dart';
import 'package:estheva_web/website/screens/home_services/body_coutouring_page_home.dart';
import 'package:estheva_web/website/screens/home_services/healthcheckup_home.dart';
import 'package:estheva_web/website/screens/home_services/iv_therapy_packages.dart';
import 'package:estheva_web/website/screens/home_services/physiotherapy_home.dart';
import 'package:estheva_web/website/screens/main_dashboard_we.dart';
import 'package:estheva_web/website/screens/offers/offers.dart';
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
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem('Home', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MainDashboardWeb()));
                  }),
                  _buildClinicServiceMenu(),
                  _buildHomeServicesMenu(),
                ],
              ),
            ),

            // Logo
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => MainDashboardWeb()));
              },
              child: Image.asset(
                "assets/logos.png", // Replace with your logo URL
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                height: 320,
                width: 300,
              ),
            ),
            // Menu items
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home Services with dropdown submenus

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
                        style: GoogleFonts.inter(color: black),
                      )),
                  // Buttons
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          title,
          style: TextStyle(color: black, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildHomeServicesMenu() {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == "Consultations") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WebDashboardDoctors()));
        }
        // Handle submenu item selection with navigation
        else if (result == 'Body Contouring at Home') {
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
        }
        //  else if (result == 'IV Drips Therapy Packages') {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               IVDripsTherapyPackages())); // Replace with the actual page for Physiotherapy
        // }
        else if (result == 'Health Tests at Home') {
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
        } else if (result == 'Offers') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OffersWeb())); // Replace with the actual page for Physiotherapy
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Consultations',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebDashboardDoctors()));
            },
            child: Text('CONSULTATIONS ONLINE'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Body Contouring at Home',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BodyContouringPageHome()));
            },
            child: Text('BODY CONTOURING'),
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
            child: Text('IV DRIPS THERAPY'),
          ),
        ),
        // PopupMenuItem<String>(
        //   value: 'IV Drips Therapy Packages',
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   IVDripsTherapyPackages())); // Navigate to Physiotherapy
        //     },
        //     child: Text('IV Drips Therapy Packages'),
        //   ),
        // ),
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
            child: Text('HEALTH TESTS'),
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
            child: Text('PHYSIOTHERAPY'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Offers',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OffersWeb())); // Navigate to Physiotherapy
            },
            child: Text('OFFERS'),
          ),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Home Care',
              style: TextStyle(color: black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicServiceMenu() {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == "Consultations") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WebDashboardDoctors()));
        }
        // Handle submenu item selection with navigation
        else if (result == 'Body Contouring at Clinic') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BodyContouringPageClinic())); // Replace with the actual page for Body Contouring
        } else if (result == 'IV Drips Therapy at Clinic') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      IVDripsTherapyClinic())); // Replace with the actual page for Body Contouring
        }

        /// else if (result == 'IV Drips Therapy Packages at Clinic') {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               IVDripsTherapyPackagesClinic())); // Replace with the actual page for Body Contouring
        // }
        else if (result == 'Health Checkup at Clinic') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HealthChecupAtClinic())); // Replace with the actual page for Body Contouring
        } else if (result == 'Physiotherapy at Clinic') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PhysiotherapyAtClinic())); // Replace with the actual page for Body Contouring
        } else if (result == 'Aesthetic at Clinic') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AestheticAtClinic())); // Replace with the actual page for Body Contouring
        } else if (result == 'Offers') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OffersWeb())); // Replace with the actual page for Physiotherapy
        }

        // Replace with the actual page for Physiotherapy
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Consultations',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebDashboardDoctors()));
            },
            child: Text('CONSULTATIONS ONLINE'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Body Contouring at Clinic',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BodyContouringPageClinic()));
            },
            child: Text('BODY CONTOURING'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'IV Drips Therapy at Clinic',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IVDripsTherapyClinic()));
            },
            child: Text('IV Drips Therapy'),
          ),
        ),
        // PopupMenuItem<String>(
        //   value: 'IV Drips Therapy Packages at Clinic',
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   IVDripsTherapyPackagesClinic())); // R
        //     },
        //     child: Text('IV DRIPS THERAPY'),
        //   ),
        // ),
        PopupMenuItem<String>(
          value: 'Physiotherapy at Clinic',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhysiotherapyAtClinic()));
            },
            child: Text('PHYSIOTHERAPY'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Aesthetic at Clinic',
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AestheticAtClinic()));
            },
            child: Text('AESTHETICS'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Health Checkup at Clinic',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthChecupAtClinic()));
            },
            child: Text('HEALTH CHECKUP'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Offers',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OffersWeb())); // Navigate to Physiotherapy
            },
            child: Text('OFFERS'),
          ),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Clinic Services',
              style: TextStyle(color: black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

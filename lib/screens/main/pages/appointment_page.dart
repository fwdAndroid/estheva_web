import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/screens/tabs/cancelled.dart';
import 'package:estheva_web/screens/tabs/completed.dart';
import 'package:estheva_web/screens/tabs/upcomming.dart';
import 'package:estheva_web/uitls/colors.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Appointments",
            style: GoogleFonts.poppins(color: appColor),
          ),
          bottom: TabBar(
            indicatorColor: mainColor,
            labelColor: mainColor,
            labelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            unselectedLabelColor: textColor,
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            tabs: const <Widget>[
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "Completed",
              ),
              Tab(
                text: "Cancelled",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[Upcoming(), Completed(), Cancelled()],
        ),
      ),
    );
  }
}

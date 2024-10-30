import 'package:estheva_web/screens/appointment_main/cancelled.dart';
import 'package:estheva_web/screens/appointment_main/completed.dart';
import 'package:estheva_web/screens/appointment_main/upcomming.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/uitls/colors.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
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
            "Records",
            style: TextStyle(
              color: appColor,
              fontFamily: 'Futura',
            ),
          ),
          bottom: TabBar(
            indicatorColor: mainColor,
            labelColor: mainColor,
            labelStyle: TextStyle(
              fontFamily: 'Futura',
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            unselectedLabelColor: textColor,
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Futura',
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

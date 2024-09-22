import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/screens/details/appointment_detail.dart';
import 'package:estheva_web/screens/tabs/doctor_appointment_details.dart';
import 'package:estheva_web/uitls/colors.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemBuilder: (context, index) {
      return Column(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => DoctorAppointmentDetails()));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/doctor.png",
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("View Doctor Appointment"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                Image.asset("assets/doctor.png"),
                Text("View Services Appointment"),
              ],
            ),
          )
        ],
      );
    }));
  }
}

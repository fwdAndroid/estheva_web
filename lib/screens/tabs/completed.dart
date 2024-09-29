import 'package:estheva_web/screens/tabs/complete_doctor_appointment.dart';
import 'package:estheva_web/screens/tabs/complete_service_appointment.dart';
import 'package:flutter/material.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => CompleteDoctorAppointment()));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/doctor.png",
                      height: 170,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Complete Doctors Appointment"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => CompleteServiceAppointment()));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/newlogo.png",
                      height: 170,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Complete Service Appointment"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

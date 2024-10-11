import 'package:estheva_web/screens/tabs/service_appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/screens/tabs/doctor_appointment_details.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
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
                        builder: (builder) => DoctorAppointmentDetails()));
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
                      child: Text(
                        "Doctor Appointment",
                        style: TextStyle(
                          fontFamily: 'Futura',
                        ),
                      ),
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
                        builder: (builder) => ServiceAppointmentDetails()));
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
                      child: Text(
                        "Service Appointment",
                        style: TextStyle(
                          fontFamily: 'Futura',
                        ),
                      ),
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

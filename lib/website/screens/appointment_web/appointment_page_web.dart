import 'package:estheva_web/website/screens/appointment_web/doctor_appointment_web.dart';
import 'package:estheva_web/website/screens/appointment_web/service_appointment_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class AppointmentPageWeb extends StatefulWidget {
  const AppointmentPageWeb({super.key});

  @override
  State<AppointmentPageWeb> createState() => _AppointmentPageWebState();
}

class _AppointmentPageWebState extends State<AppointmentPageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/newlogo.png",
            height: 200,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                              builder: (builder) => DoctorAppointmentWeb()));
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
                            child: Text("Doctor Appointment"),
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
                              builder: (builder) => ServiceAppointmentWeb()));
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
                            child: Text("Service Appointment"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
